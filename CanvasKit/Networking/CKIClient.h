//
//  CKIClient.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "CKIPagedResponse.h"

@class CKIModel;
@class CKIUser;
@class FXKeychain;

@protocol CKIContext;

/**
 The client responsible for processing all networking requests to
 the canvas API.
 */
@interface CKIClient : AFHTTPSessionManager

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *sharedSecret;
@property (nonatomic, strong) NSString *keyChainId;
@property (nonatomic, strong) NSString *authToken;

/**
 The user that is currently logged in via this client.
 */
@property (nonatomic, strong) CKIUser *currentUser;

/**
 The keychain used by the client to store secrets.
 */
@property (nonatomic, readonly) FXKeychain *keychain;

/**
 Create a canvas client for a given domain specified by the base URL.
 
 @param baseURL the base URL to be used by the client
 */
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;


/**
 Helper method for setting the auth token after successful login
 
 @param Authentication token recieved from OAuth2 process
 */
- (void)setAuthToken:(NSString *)authToken;

/**
 Checks to see if the user is logged in by checking for the OAuthToken in the keychain.
 */
- (BOOL)isLoggedIn;

#pragma mark - JSON API Helpers

/**
 Generic helper for fetching a single CKIModel from a JSON API Endpoint.
 
 @param path The path of the API endpoint
 @param parameters the parameters to be applied to the request
 @param modelClass the specific subclass of CKIModel that the response will represent
 @param context the context of the CKIModel that will be fetched (may be nil)
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void (^)(CKIModel *model))success failure:(void (^)(NSError *error))failure;

/**
 Fetch the given page number from a paginated JSON API endpoint.
 
 @param path the paginated JSON API endpoint (ex. @"api/v1/courses/123/modules")
 @param parameters the parameters to be applied to the request
 @param modelClass the class of the model to generate
 @param success the success block which will accept the CKIPagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters valueTransformer:(NSValueTransformer *)valueTransformer context:(id<CKIContext>)context success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

@end
