//
//  CKIClient.m
//  CanvasKit
//
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <Mantle/Mantle.h>
#import <FXKeychain.h>

#import "CKIClient.h"
#import "CKIModel.h"
#import "CKIUser.h"
#import "CKILoginViewController.h"
#import "NSHTTPURLResponse+Pagination.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

#pragma mark - Keychain Helpers

static const NSString *kCKIKeychainOAuthTokenKey = @"AUTH_TOKEN";
static const NSString *kCKIKeychainDomainKey = @"DOMAIN_KEY";
static const NSString *kCKIKeychainCurrentUserKey = @"CANVAS_CURRENT_USER_KEY";

@interface FXKeychain (CKIKeychain)
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSURL *domain;
@property (nonatomic, strong) CKIUser *currentUser;
@end

@implementation FXKeychain (CBIKeychain)

- (NSString *)oauthToken
{
    return self[kCKIKeychainOAuthTokenKey];
}

- (void)setOauthToken:(NSString *)oauthToken
{
    self[kCKIKeychainOAuthTokenKey] = oauthToken;
}

- (NSURL *)domain
{
    return [NSURL URLWithString:self[kCKIKeychainDomainKey]];
}

- (void)setDomain:(NSURL *)domain
{
    self[kCKIKeychainDomainKey] = domain.absoluteString;
}

- (CKIUser *)currentUser
{
    NSDictionary *dictionary = self[kCKIKeychainCurrentUserKey];
    return [CKIUser modelFromJSONDictionary:dictionary];
}

- (void)setCurrentUser:(CKIUser *)currentUser
{
    NSDictionary *userDictionary = [currentUser JSONDictionary];
    self[kCKIKeychainCurrentUserKey] = userDictionary;
}

@end

#pragma mark - Client

@interface CKIClient ()
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *oauthToken;

@property (nonatomic, strong) FXKeychain *keychain;
@end

@implementation CKIClient

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret keychainServiceID:(NSString *)keychainID accessGroup:(NSString *)accessGroup;
{
    return [[self alloc] initWithBaseURL:baseURL clientID:clientID clientSecret:clientSecret keychainServiceID:keychainID accessGroup:accessGroup];
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret keychainServiceID:(NSString *)keychainID accessGroup:(NSString *)accessGroup;
{
    NSParameterAssert(baseURL);
    NSParameterAssert(clientID);
    NSParameterAssert(clientSecret);

    self = [super initWithBaseURL:baseURL];;
    if (!self) {
        return nil;
    }

    [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [self setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];

    self.clientID = clientID;
    self.clientSecret = clientSecret;
    self.keychain = [[FXKeychain alloc] initWithService:keychainID accessGroup:accessGroup];

    RACSignal *oauthTokenSignal = RACObserve(self, oauthToken);

    RAC(self, isLoggedIn) = [oauthTokenSignal map:^id(id value) {
        return @(value != nil);
    }];

    return self;
}

+ (instancetype)loadClientFromKeychainWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret keychainServiceID:(NSString *)keychainID accessGroup:(NSString *)accessGroup;
{
    FXKeychain *keychain = [[FXKeychain alloc] initWithService:keychainID accessGroup:accessGroup];

    NSString *oauthToken = keychain.oauthToken;
    if (!oauthToken) {
        return nil;
    }

    NSURL *baseURL = keychain.domain;

    CKIClient *client = [[CKIClient alloc] initWithBaseURL:baseURL clientID:clientID clientSecret:clientSecret keychainServiceID:keychainID accessGroup:accessGroup];
    client.oauthToken = oauthToken;
    client.currentUser = keychain.currentUser;
    return client;
}

#pragma mark - Keychain

- (void)saveToKeychain
{
    self.keychain.oauthToken = self.oauthToken;
    self.keychain.currentUser = self.currentUser;
    self.keychain.domain = self.baseURL;
}

- (void)clearKeychain
{
    [self.keychain removeObjectForKey:kCKIKeychainOAuthTokenKey];
    [self.keychain removeObjectForKey:kCKIKeychainDomainKey];
    [self.keychain removeObjectForKey:kCKIKeychainCurrentUserKey];
}

#pragma mark - Properties

- (void)setOauthToken:(NSString *)oauthToken
{
    _oauthToken = oauthToken;
    [(AFHTTPRequestSerializer*)self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", oauthToken] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - OAuth

- (RACSignal *)postOauthCode:(NSString *)temporaryCode
{
    NSDictionary *params = @{
            @"client_id": self.clientID,
            @"client_secret": self.clientSecret,
            @"code": temporaryCode
    };

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self POST:@"/login/oauth2/token" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)login
{
    // don't log in again if already logged in
    if (self.isLoggedIn) {
        return nil;
    }

    return [[[[[self authorizeWithServerUsingWebBrowser] flattenMap:^RACStream *(NSString *temporaryCode) {
        return [self postOauthCode:temporaryCode];
    }] flattenMap:^RACStream *(NSDictionary *responseObject) {
        self.oauthToken = responseObject[@"access_token"];
        return [self fetchCurrentUser];
    }] map:^id(CKIUser *user) {
        self.currentUser = user;
        [self saveToKeychain];
        return self;
    }] doError:^(NSError *error) {
        NSLog(@"CanvasKit OAuth failed with error: %@", error);
        [self clearCookies];
        [self clearKeychain];
    }];
}

- (void)logout
{
    self.currentUser = nil;
    self.oauthToken = nil;
    [self clearKeychain];
    [self clearCookies];
}

- (NSURLRequest *)oauthRequest
{
    NSString *urlString = [NSString stringWithFormat:@"%@/login/oauth2/auth?client_id=%@&response_type=code&redirect_uri=urn:ietf:wg:oauth:2.0:oob&mobile=1"
            , self.baseURL.absoluteString
            , self.clientID];
    if (self.forceCanvasLogin) {
        urlString = [urlString stringByAppendingString:@"&canvas_login=1"];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"CanvasKit/1.0" forHTTPHeaderField:@"User-Agent"];
    return request;
}

- (RACSignal *)authorizeWithServerUsingWebBrowser
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        CKILoginViewController *loginViewController = [[CKILoginViewController alloc] initWithOAuthRequest:self.oauthRequest];
        __weak CKILoginViewController *weakLoginViewController = loginViewController;
        loginViewController.oauthSuccessBlock = ^(NSString *authToken) {
            [subscriber sendNext:authToken];
            [subscriber sendCompleted];
        };
        loginViewController.oauthFailureBlock = ^(NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        };

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [navigationController.navigationBar setBarTintColor:[UIColor darkGrayColor]];
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [navigationController.navigationBar setTranslucent:YES];

        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:loginViewController action:@selector(cancelOAuth)];
        [loginViewController.navigationItem setRightBarButtonItem:button];

        UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        [presentingViewController presentViewController:navigationController animated:YES completion:nil];

        return [RACDisposable disposableWithBlock:^{
            [weakLoginViewController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

- (RACSignal *)fetchCurrentUser
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/profile"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIUser class] context:nil];
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

- (RACSignal *)fetchResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context
{
    NSAssert([modelClass isSubclassOfClass:[CKIModel class]], @"Can only fetch CKIModels");

    NSValueTransformer *transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:modelClass];
    return [self fetchResponseAtPath:path parameters:parameters transformer:transformer context:context];
}


- (RACSignal *)fetchResponseAtPath:(NSString *)path parameters:(NSDictionary *)parameters transformer:(NSValueTransformer *)transformer context:(id<CKIContext>)context
{
    NSParameterAssert(path);
    NSParameterAssert(transformer);

    NSDictionary *newParameters = [@{@"per_page": @50} dictionaryByAddingObjectsFromDictionary:parameters];

    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self GET:path parameters:newParameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSURL *currentPage = response.currentPage;
            NSURL *nextPage = response.nextPage;
            NSURL *lastPage = response.lastPage;

            RACSignal *thisPageSignal = [self parseResponseWithTransformer:transformer fromJSON:responseObject context:context];
            RACSignal *nextPageSignal = [RACSignal empty];

            if (nextPage && ![currentPage isEqual:lastPage]) {
                nextPageSignal = [self fetchResponseAtPath:nextPage.relativeString parameters:newParameters transformer:transformer context:context];
            }

            [[thisPageSignal concat:nextPageSignal] subscribe:subscriber];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"-fetchResponseAtPath: %@ parameters: %@ transformer: %@ context: %@", path, newParameters, transformer, context];
}

- (RACSignal *)parseResponseWithTransformer:(NSValueTransformer *)transformer fromJSON:(id)responseObject context:(id<CKIContext>)context
{
    NSParameterAssert(transformer);
    NSParameterAssert(responseObject);
    NSAssert([responseObject isKindOfClass:NSArray.class] || [responseObject isKindOfClass:NSDictionary.class], @"Response object must be either an array or dictionary");

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if ([responseObject isKindOfClass:NSArray.class]) {
            NSArray *jsonModels = responseObject;
            NSArray *models = [[jsonModels.rac_sequence map:^id(id jsonModel) {
                return [self parseModel:transformer fromJSON:jsonModel context:context];
            }] array];
            [subscriber sendNext:models];
        }
        else {
            NSDictionary *jsonModel = responseObject;
            CKIModel *model = [self parseModel:transformer fromJSON:jsonModel context:context];
            [subscriber sendNext:model];
        }

        [subscriber sendCompleted];
        return nil;
    }];
}

- (CKIModel *)parseModel:(NSValueTransformer *)transformer fromJSON:(NSDictionary *)jsonDictionary context:(id)context
{
    NSParameterAssert(transformer);
    NSParameterAssert(jsonDictionary);

    id tranformedValue = [transformer transformedValue:jsonDictionary];
    NSAssert([tranformedValue isKindOfClass:CKIModel.class], @"Transformer gave back an object of type %@, expected a CKIModel subclass.", [tranformedValue class]);
    CKIModel *model = (CKIModel *)tranformedValue;
    model.context = context;
    return model;
}


#pragma mark - POSTing

- (RACSignal *)createModelAtPath:(NSString *)path parameters:(NSDictionary *)parameters modelClass:(Class)modelClass context:(id<CKIContext>)context
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [[self parseResponseWithTransformer:[NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:modelClass] fromJSON:responseObject context:context] subscribe:subscriber];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

#pragma mark - PUTing

- (RACSignal *)updateModel:(CKIModel *)model parameters:(NSDictionary *)parameters
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self PUT:model.path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [[self parseResponseWithTransformer:[NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[model class]] fromJSON:responseObject context:model.context] subscribe:subscriber];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
