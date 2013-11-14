//
//  CKIClient.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <FXKeychain.h>

#import "CKIClient.h"
#import "CKIModel.h"
#import "CKIUser.h"
#import "CKILoginViewController.h"
#import "NSHTTPURLResponse+Pagination.h"



#pragma mark - Keychain Helpers

static const NSString *kCKIKeychainAuthTokenKey = @"AUTH_TOKEN";
static const NSString *kCKIKeychainDomainKey = @"DOMAIN_KEY";
static const NSString *kCKIKeychainCurrentUserKey = @"CANVAS_CURRENT_USER_KEY";

FXKeychain * cki_keychainForKeychainID(NSString * keychainID)
{
    FXKeychain *keychain;
    if (keychainID) {
        keychain = [[FXKeychain alloc] initWithService:keychainID accessGroup:nil];
    } else {
        keychain = [FXKeychain defaultKeychain];
    }
    
    return keychain;
}

NSString * cki_loadOAuthTokenFromKeychain(NSString *keychainID)
{
    FXKeychain *keychain = cki_keychainForKeychainID(keychainID);
    return keychain[kCKIKeychainAuthTokenKey];
}

NSString * cki_loadDomainFromKeychain(NSString *keychainID)
{
    FXKeychain *keychain = cki_keychainForKeychainID(keychainID);
    return keychain[kCKIKeychainDomainKey];
}

CKIUser * cki_loadCurrentUserFromKeychain(NSString *keychainID)
{
    FXKeychain *keychain = cki_keychainForKeychainID(keychainID);
    NSDictionary *dictionary = keychain[kCKIKeychainCurrentUserKey];
    return [CKIUser modelFromJSONDictionary:dictionary];
}


#pragma mark - Client



@interface CKIClient ()
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *sharedSecret;
@property (nonatomic, strong) NSString *keychainID;
@property (nonatomic, strong) NSString *authToken;

@property (nonatomic, strong) FXKeychain *keychain;
@end

@implementation CKIClient


+ (instancetype)clientWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret
{
    return [self clientWithBaseURL:baseURL clientID:clientID sharedSecret:sharedSecret keychainID:nil];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret keychainID:(NSString *)keychainID
{
    CKIClient *client = [self loadClientWithClientID:clientID sharedSecret:sharedSecret fromKeychain:keychainID];
    
    // create a new client if we can't find existing one in the keychain
    if (!client) {
        client = [[self alloc] initWithBaseURL:baseURL clientID:clientID sharedSecret:sharedSecret keychainID:keychainID];
    }
    
    return client;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret keychainID:(NSString *)keychainID
{
    NSParameterAssert(baseURL);
    NSParameterAssert(clientID);
    NSParameterAssert(sharedSecret);
    
    self = [super initWithBaseURL:baseURL];;
    if (!self) {
        return nil;
    }
    
    [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    self.clientID = clientID;
    self.sharedSecret = sharedSecret;
    self.keychainID = keychainID;
    
    return self;
}

// returns nil if the keychain doesn't have an oauth token
+ (instancetype)loadClientWithClientID:(NSString *)clientID sharedSecret:(NSString *)sharedSecret fromKeychain:(NSString *)keychainID
{
    NSString *oauthToken = cki_loadOAuthTokenFromKeychain(keychainID);
    if (!oauthToken) {
        return nil;
    }
    
    NSString *domainString = cki_loadDomainFromKeychain(keychainID);
    NSURL *baseURL = [NSURL URLWithString:domainString];
    
    CKIUser *currentUser = cki_loadCurrentUserFromKeychain(keychainID);
    
    CKIClient *client = [[CKIClient alloc] initWithBaseURL:baseURL clientID:clientID sharedSecret:sharedSecret keychainID:keychainID];
    client.authToken = oauthToken;
    client.currentUser = currentUser;
    return client;
}

#pragma mark - Keychain

- (FXKeychain *)keychain
{
    if (_keychain) {
        return _keychain;
    }
    
    _keychain = cki_keychainForKeychainID(self.keychainID);
    
    return _keychain;
}

- (void)saveToKeychain
{
    self.keychain[kCKIKeychainAuthTokenKey] = self.authToken;
    self.keychain[kCKIKeychainDomainKey] = self.baseURL.absoluteString;
    
    NSDictionary *userDictionary = [self.currentUser JSONDictionary];
    self.keychain[kCKIKeychainCurrentUserKey] = userDictionary ;
}

- (void)clearKeychain
{
    [self.keychain removeObjectForKey:kCKIKeychainAuthTokenKey];
    [self.keychain removeObjectForKey:kCKIKeychainDomainKey];
    [self.keychain removeObjectForKey:kCKIKeychainCurrentUserKey];
}

#pragma mark - Properties

- (void)setAuthToken:(NSString *)authToken
{
    _authToken = authToken;
    [(AFHTTPRequestSerializer*)self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", authToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - OAuth

- (void)loginWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure
{
    // don't log in again if already logged in
    if (self.isLoggedIn) {
        if (success) {
            success();
        }
        return;
    }
    
    // set up a failure block to share for all callback-hell error handling
    void (^failureBlock)(NSError *error) = ^void(NSError *error) {
        NSLog(@"CanvasKit OAuth failed with error: %@", error);
        [self clearCookies];
        [self clearKeychain];
        if (failure) {
            failure(error);
        }
    };
    
    // pop open a webview and login
    [self showWebviewLoginWithSuccess:^(NSString *oauthCode){
        [self postOAuthCode:oauthCode success:^(id responseObject) {
            [self processOAuthTokenFromOAuthResponse:responseObject];
            [self processUserFromOAuthResponse:responseObject];
            [self saveToKeychain];
            if (success) {
                success();
            }
        } failure:failureBlock];
    } failure:failureBlock];
}

- (void)logout
{
    self.currentUser = nil;
    [self clearKeychain];
    [self clearCookies];
}

- (BOOL)isLoggedIn
{
    return self.authToken != nil;
}

- (NSURLRequest *)oauthRequest
{
    NSString *urlString = [NSString stringWithFormat:@"%@/login/oauth2/auth?client_id=%@&response_type=%@&redirect_uri=%@&mobile=1&canvas_login=1"
                           , self.baseURL.absoluteString
                           , self.clientID
                           , @"code"
                           , @"urn:ietf:wg:oauth:2.0:oob"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"CanvasKit/1.0" forHTTPHeaderField:@"User-Agent"];
    return request;
}

- (void)showWebviewLoginWithSuccess:(void(^)(NSString *authToken))success failure:(void(^)(NSError *error))failure
{
    CKILoginViewController *loginViewController = [[CKILoginViewController alloc] initWithOAuthRequest:self.oauthRequest];
    __weak CKILoginViewController *weakLoginViewController = loginViewController;
    loginViewController.oauthSuccessBlock = ^(NSString *authToken) {
        [weakLoginViewController dismissViewControllerAnimated:YES completion:nil];
        if (success) {
            success(authToken);
        }
    };
    loginViewController.oauthFailureBlock = ^(NSError *error) {
        [weakLoginViewController dismissViewControllerAnimated:YES completion:nil];
        if (failure) {
            failure(error);
        }
    };
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [navigationController.navigationBar setBarTintColor:[UIColor darkGrayColor]];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [navigationController.navigationBar setTranslucent:YES];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:loginViewController action:@selector(cancelOAuth)];
    [loginViewController.navigationItem setRightBarButtonItem:button];
    
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    [presentingViewController presentViewController:navigationController animated:YES completion:nil];
}

/**
 Makes request to get the |auth_token| from the backend.
 
 @param code The code obtained from the authentication server in the OAuth2 process
 */
- (void)postOAuthCode:(id)code success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [self POST:@"/login/oauth2/token" parameters:@{@"client_id":self.clientID, @"client_secret": self.sharedSecret, @"code": code} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (void)processOAuthTokenFromOAuthResponse:(NSDictionary *)jsonResponse
{
    self.authToken = jsonResponse[@"access_token"];
}

- (void)processUserFromOAuthResponse:(NSDictionary *)jsonResponse
{
    self.currentUser = [CKIUser modelFromJSONDictionary:jsonResponse[@"user"]];
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/profile"];
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIUser class] context:nil success:^(CKIModel *user) {
        self.currentUser = (CKIUser *)user;
        [self saveToKeychain];
    } failure:^(NSError *error) {
        NSLog(@"Error fetching user details: %@", error);
    }];
}

#pragma mark - Caching & Cookies

- (void)clearCookies
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:self.baseURL];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *cookie, NSUInteger idx, BOOL *stop) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }];
}

#pragma mark - JSON API Helpers

- (void)fetchModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context success:(void (^)(CKIModel *model))success failure:(void (^)(NSError *error))failure
{
    NSAssert([modelClass isSubclassOfClass:[CKIModel class]], @"modelClass must be a subclass of CKIModel");
    
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
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
    
    NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:modelClass];
    [self fetchPagedResponseAtPath:path parameters:parameters valueTransformer:valueTransformer context:context success:success failure:failure];
}


- (void)fetchPagedResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters valueTransformer:(NSValueTransformer *)valueTransformer context:(id<CKIContext>)context success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSAssert(valueTransformer, @"valueTransformer cannot be nil");
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CKIPagedResponse *pagedResponse = [CKIPagedResponse pagedResponseForTask:task responseObject:responseObject valueTransformer:valueTransformer context:context client:self];
            success(pagedResponse);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
