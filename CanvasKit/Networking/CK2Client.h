//
//  CK2Client.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <AFHTTPSessionManager.h>
#import "CK2PagedResponse.h"

@class CK2Model;
@protocol CK2Context;

/**
 The client responsible for processing all networking requests to
 the canvas API.
 
 Example:
 NSURL *baseURL = [NSURL URLWithString:@"https://canvas.instructure.com"];
 CK2Client *client = [CK2Client clientWithBaseURL:baseURL];
 [CK2Client setCurrentClient:client];
 
 // once the currentClient has been set, anyone can use it.
 [CK2Client currentClient];
 */
@interface CK2Client : AFHTTPSessionManager

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *sharedSecret;
@property (nonatomic, strong) NSString *keyChainId;

/**
 Create a canvas client for a given domain specified by the base URL.
 
 @param baseURL the base URL to be used by the client
 */
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;

/**
 Get the client to be used for the specified current domain.
 
 @return the CK2Client as specified by the currentDomain property
 @warning an exception will be raised if the currentDomain has not been set first.
 @see setCurrentDomain:
 */
+ (instancetype)currentClient;

/**
 Set the new current client.
 
 @param currentClient the new current client
 */
+ (void)setCurrentClient:(CK2Client *)currentClient;


/**
 Helper method for setting the auth token after successful login
 
 @param Authentication token recieved from OAuth2 process
 */
- (void)setAuthToken:(NSString *)authToken;

#pragma mark - JSON API Helpers

/**
 Generic helper for fetching a single CK2Model from a JSON API Endpoint.
 
 @param path The path of the API endpoint
 @param parameters the parameters to be applied to the request
 @param modelClass the specific subclass of CK2Model that the response will represent
 @param context the context of the CK2Model that will be fetched (may be nil)
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void (^)(CK2Model *model))success failure:(void (^)(NSError *error))failure;

/**
 Fetch the given page number from a paginated JSON API endpoint.
 
 @param path the paginated JSON API endpoint (ex. @"api/v1/courses/123/modules")
 @param parameters the parameters to be applied to the request
 @param modelClass the class of the model to generate
 @param success the success block which will accept the CK2PagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CK2Context>)context success:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
