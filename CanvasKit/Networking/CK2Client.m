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

@implementation CK2Client

+ (instancetype)sharedClient {
    static CK2Client *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CK2Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://mobiledev.instructure.com/"]];
        [_sharedClient setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [_sharedClient setResponseSerializer:[AFJSONResponseSerializer serializer]];
    });

    return _sharedClient;
}

#pragma mark - OAuth

- (void)setAuthToken:(NSString *)authToken
{
    [(AFHTTPRequestSerializer*)[CK2Client sharedClient].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - JSON API Helpers

- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void (^)(CK2Model *model))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CK2Model class]], @"modelClass must be a subclass of CK2Model");
    
    
    [[CK2Client sharedClient] GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CK2Model *model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:nil];
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

- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CK2Model class]], @"Can only fetch CK2Models");

    [[CK2Client sharedClient] GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            CK2PagedResponse *pagedResponse = [CK2PagedResponse pagedResponseForOperation:operation responseObject:responseObject modelClass:modelClass context:context];
            success(pagedResponse);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
