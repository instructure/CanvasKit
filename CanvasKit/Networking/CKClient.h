//
//  CKClient.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <AFHTTPRequestOperationManager.h>
#import "CKPagedResponse.h"

@class CKModel;
@protocol CKContext;

@interface CKClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *sharedSecret;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *keyChainId;

/**
 Canvas Kit netorking singleton object
 
 @return the CKClient singleton
 */
+ (instancetype)sharedClient;


/**
 Helper method for setting the auth token after successful login
 
 @param Authentication token recieved from OAuth2 process
 */
- (void)setAuthToken:(NSString *)authToken;

#pragma mark - JSON API Helpers

/**
 Generic helper for fetching a single CKModel from a JSON API Endpoint.
 
 @param path The path of the API endpoint
 @param parameters the parameters to be applied to the request
 @param modelClass the specific subclass of CKModel that the response will represent
 @param context the context of the CKModel that will be fetched (may be nil)
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKContext>)context success:(void (^)(CKModel *model))success failure:(void (^)(NSError *error))failure;

/**
 Fetch the given page number from a paginated JSON API endpoint.
 
 @param path the paginated JSON API endpoint (ex. @"api/v1/courses/123/modules")
 @param parameters the parameters to be applied to the request
 @param modelClass the class of the model to generate
 @param success the success block which will accept the CKPagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKContext>)context success:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
