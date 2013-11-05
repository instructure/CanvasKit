//
//  CKILocalUser+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKILocalUser+Networking.h"
#import "CKIClient.h"
#import "Constants.h"
#import "CKILoginViewController.h"
#import "CKIActivityStreamItem.h"

@implementation CKILocalUser (Networking)

- (void)fetchAttributesWithsuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[self path] stringByAppendingPathComponent:@"profile"];
    
    [[CKIClient currentClient] GET:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
        CKILocalUser *user = [MTLJSONAdapter modelOfClass:[CKILocalUser class] fromJSONDictionary:responseObject error:nil];
        [[CKILocalUser sharedUser] mergeValuesForKeysFromModel:user];
        
        if (success)
            success();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)performLoginWithDomain:(NSString *)domain success:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    
    NSAssert(domain, @"You must provide a domain for login");
    
    CKIClient *sharedClient = [CKIClient currentClient];
    
    if (! sharedClient.clientId || ! sharedClient.sharedSecret) {
        failure([NSError errorWithDomain:kCKIErrorDomain code:kCKIErrorCodeNotPreparedForOAuth userInfo:@{NSLocalizedDescriptionKey: @"Client ID and shared secret must be set prior to authentication. See CanvasKit.h prepare methods."}]);
        return;
    }
    
    CKILoginViewController *loginViewController = [[CKILoginViewController alloc] initWithDomain:domain success:^{
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [navigationController.navigationBar setBarTintColor:[UIColor darkGrayColor]];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [navigationController.navigationBar setTranslucent:YES];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:loginViewController action:@selector(cancelOAuth)];
    [loginViewController.navigationItem setRightBarButtonItem:button];
    
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [presentingViewController presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)fetchActivityStreamWithSuccess:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = @"/api/v1/users/self/activity_stream";
    
    NSValueTransformer *valueTransformer = [CKIActivityStreamItem activityStreamItemTransformer];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil valueTransformer:valueTransformer context:nil success:success failure:failure];
}

@end
