//
//  CK2LoginViewController.m
//  OAuthTesting
//
//  Created by rroberts on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2LoginViewController.h"
#import "NSString+CK2Additions.h"
#import "CK2Client.h"
#import "CK2LocalUser.h"
#import "Constants.h"
#import <FXKeychain/FXKeychain.h>
#import <AFHTTPRequestOperation.h>
#import "Mantle.h"
#import "CK2Client+Keychain.h"

@interface CK2LoginViewController () <UIWebViewDelegate>

@end

@implementation CK2LoginViewController

- (id)initWithDomain:(NSString *)domain success:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    self = [super init];
    if (self) {
        [self setOauthSuccessBlock:success];
        [self setOauthFailureBlock:failure];
        [self setDomain:domain];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CK2Client *sharedClient = [CK2Client currentClient];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSString *urlString = [NSString stringWithFormat:@"http://%@/login/oauth2/auth?client_id=%@&response_type=%@&redirect_uri=%@&mobile=1&canvas_login=1"
                           , self.domain
                           , sharedClient.clientId
                           , @"code"
                           , @"urn:ietf:wg:oauth:2.0:oob"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"CanvasKit/1.0" forHTTPHeaderField:@"User-Agent"];
    [self.webView loadRequest:request];
    [self.webView setDelegate:self];
    [self.webView setScalesPageToFit:YES];
    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor blackColor]];
    
    self.view = self.webView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Web view loaded");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Webview failed to load");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([self getValueFromRequest:request withKey:@"code"]  ) {
        [self getAuthTokenWithCode:[self getValueFromRequest:request withKey:@"code"]];
        return NO;
    } else if ([self getValueFromRequest:request withKey:@"error"]) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@", self.domain]]];
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        self.oauthFailureBlock([NSError errorWithDomain:@"com.instructure.canvaskit" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Authentication failed. Most likely the user denied the request for access."}]);
        return NO;
    }
    
    return YES;
}

/**
 Makes request to get the |auth_token| from the backend.
 
 @param code The code obtained from the authentication server in the OAuth2 process
 */
- (void)getAuthTokenWithCode:(id)code
{
    CK2Client *client = [CK2Client currentClient];
    
    [client POST:@"/login/oauth2/token" parameters:@{@"client_id":client.clientId, @"client_secret": client.sharedSecret, @"code": code} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[CK2Client currentClient].keychain setObject:responseObject[@"access_token"] forKey:kCK2KeychainAuthTokenKey];
        [[CK2Client currentClient] setAuthToken:responseObject[@"access_token"]];
        
        CK2LocalUser *newUser = [MTLJSONAdapter modelOfClass:[CK2LocalUser class] fromJSONDictionary:responseObject[@"user"] error:nil];
        [[CK2LocalUser sharedUser] mergeValuesForKeysFromModel:newUser];
        
        self.oauthSuccessBlock();
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        self.oauthFailureBlock(error);
        
    }];
    
}

- (void)cancelOAuth
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.oauthFailureBlock([NSError errorWithDomain:@"com.instructure.canvaskit" code:0 userInfo:@{NSLocalizedDescriptionKey: @"User cancelled authentication"}]);
    }];
}

/**
 Checks the query parameters of the |request| for the |key|
 
 @param request The request object that may contain the specified key in the query parameters
 @param key The key for the value desired from the query parameters
 */
- (id)getValueFromRequest:(NSURLRequest *)request withKey:(NSString *)key
{
    NSString *query = request.URL.query;
    NSDictionary *parameters = [query queryParameters];
    
    return parameters[key];
}



@end
