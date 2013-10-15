//
//  CKClient.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CKClient.h"
#import "CKModel.h"
#import "NSHTTPURLResponse+Pagination.h"

@implementation CKClient

+ (instancetype)sharedClient {
    static CKClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CKClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://mobiledev.instructure.com/"]];
        [_sharedClient setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [_sharedClient setResponseSerializer:[AFJSONResponseSerializer serializer]];
    });

    return _sharedClient;
}

#pragma mark - OAuth

- (void)setAuthToken:(NSString *)authToken
{
    [(AFHTTPRequestSerializer*)[CKClient sharedClient].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - JSON API Helpers

- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKContext>)context success:(void (^)(CKModel *model))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CKModel class]], @"modelClass must be a subclass of CKModel");
    
    
    [[CKClient sharedClient] GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CKModel *model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:nil];
        model.context = context;
        
        if (success) {
            success(model);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - Paginated JSON API Helpers

- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKContext>)context success:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CKModel class]], @"Can only fetch CKModels");

    [[CKClient sharedClient] GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            CKPagedResponse *pagedResponse = [CKPagedResponse pagedResponseForOperation:operation responseObject:responseObject modelClass:modelClass context:context];
            success(pagedResponse);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
