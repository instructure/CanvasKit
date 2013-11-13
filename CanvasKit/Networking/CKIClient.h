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

@property (nonatomic, readonly) NSString *clientID;
@property (nonatomic, readonly) NSString *sharedSecret;
@property (nonatomic, readonly) NSString *keyChainId;
@property (nonatomic, readonly) NSString *oauthToken;

/**
 The user that is currently logged in via this client.
 */
@property (nonatomic, strong) CKIUser *currentUser;

/**
 Instantiates a canvas client from the default keychain if the OAuth Token is stored there, otherwise generates a new client.
 
 @param baseURL the base URL to be used by the client
 @param clientID the special client ID that uniquely identifies this application
 @param sharedSecret the shared secret for the application
 */
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret;

/**
 Instantiates a canvas client from the given keychain if the OAuth Token is stored there, otherwise generates a new client.
 
 @param baseURL the base URL to be used by the client
 @param clientID the special client ID that uniquely identifies this application
 @param sharedSecret the shared secret for the application
 @param keychainID the keychain for the oauth token. Uses the default keychain if nil.
 */
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret keychainID:(NSString *)keychainID;

/**
 Creates a new canvas client.
 
 @param baseURL the base URL to be used by the client
 @param clientID the special client ID that uniquely identifies this application
 @param sharedSecret the shared secret for the application
 @param keychainID the keychain for the oauth token. Uses the default keychain if nil.
 */
- (instancetype)initWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret keychainID:(NSString *)keychainID;

#pragma mark - OAuth

/**
 Starts the OAuth2 authentication process. The user will be aksed to login to Canvas. Once logged in the user will have the option to allow the app to authenticate via Canvas.
 
 @warning CanvasKit must be prepared for OAuth2 before this method is called.
 @see CanvasKit.h
 */
- (void)loginWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 Logs out the current user, clears the keychain and all cookies related to the baseURL.
 */
- (void)logout;

/**
 Checks to see if the user is logged in by checking for the OAuthToken in the keychain.
 */
- (BOOL)isLoggedIn;

/**
 Request object for making the request to get the OAuth Token.
 */
- (NSURLRequest *)oauthRequest;

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
 Fetch a paginated response from the given JSON API endpoint.
 
 @param path the paginated JSON API endpoint (ex. @"api/v1/courses/123/modules")
 @param parameters the parameters to be applied to the request
 @param modelClass the class of the model to generate
 @param success the success block which will accept the CKIPagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;


/**
 Fetch a paginated response from the given JSON API endpoint.
 
 @param path the paginated JSON API endpoint (ex. @"api/v1/courses/123/modules")
 @param parameters the parameters to be applied to the request
 @param valueTransformer an NSValueTransformer that transforms dictionaries into CKIModels
 @param success the success block which will accept the CKIPagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters valueTransformer:(NSValueTransformer *)valueTransformer context:(id<CKIContext>)context success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

@end
