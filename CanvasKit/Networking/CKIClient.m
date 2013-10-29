//
//  CKIClient.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CKIClient.h"
#import "CKIModel.h"
#import "NSHTTPURLResponse+Pagination.h"

static CKIClient *_currentClient;

@implementation CKIClient

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL
{
    CKIClient *client = [[self alloc] initWithBaseURL:baseURL];
    [client setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [client setResponseSerializer:[AFJSONResponseSerializer serializer]];
    return client;
}

+ (instancetype)currentClient
{
    NSAssert(_currentClient, @"You must set the currentClient before you can call currentClient");
    
    return _currentClient;
}

+ (void)setCurrentClient:(CKIClient *)client
{
    @synchronized([CKIClient class]) {
        if ([_currentClient isEqual:client]) {
            return;
        }
        
        [_currentClient invalidateSessionCancelingTasks:YES];
        _currentClient = client;
    }
}

#pragma mark - OAuth

- (void)setAuthToken:(NSString *)authToken
{
    _authToken = authToken;
    [(AFHTTPRequestSerializer*)self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - JSON API Helpers

- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void (^)(CKIModel *model))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CKIModel class]], @"modelClass must be a subclass of CKIModel");
    
    
    [[CKIClient currentClient] GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CKIModel *model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:nil];
            model.context = context;
            
            success(model);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - Paginated JSON API Helpers

- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CKIModel class]], @"Can only fetch CKIModels");

    [[CKIClient currentClient] GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CKIPagedResponse *pagedResponse = [CKIPagedResponse pagedResponseForTask:task responseObject:responseObject modelClass:modelClass context:context];
            success(pagedResponse);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
}

@end
