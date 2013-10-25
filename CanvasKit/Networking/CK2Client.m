//
//  CK2Client.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CK2Client.h"
#import "CK2Model.h"
#import "NSHTTPURLResponse+Pagination.h"

static CK2Client *_currentClient;

@implementation CK2Client

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL
{
    CK2Client *client = [[self alloc] initWithBaseURL:baseURL];
    [client setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [client setResponseSerializer:[AFJSONResponseSerializer serializer]];
    return client;
}

+ (instancetype)currentClient
{
    NSAssert(_currentClient, @"You must set the currentClient before you can call currentClient");
    
    return _currentClient;
}

+ (void)setCurrentClient:(CK2Client *)client
{
    @synchronized([CK2Client class]) {
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
    [(AFHTTPRequestSerializer*)[CK2Client currentClient].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - JSON API Helpers

- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void (^)(CK2Model *model))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CK2Model class]], @"modelClass must be a subclass of CK2Model");
    
    
    [[CK2Client currentClient] GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CK2Model *model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:nil];
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

- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CK2Model class]], @"Can only fetch CK2Models");

    [[CK2Client currentClient] GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CK2PagedResponse *pagedResponse = [CK2PagedResponse pagedResponseForTask:task responseObject:responseObject modelClass:modelClass context:context];
            success(pagedResponse);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
}

@end
