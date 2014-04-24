//
//  CKILoginViewController.m
//  OAuthTesting
//
//  Created by rroberts on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKILoginViewController.h"
#import "NSString+CKIAdditions.h"

@interface CKILoginViewController () <UIWebViewDelegate>
@property (nonatomic, copy) NSURLRequest *request;
@end

@implementation CKILoginViewController

- (id)initWithRequest:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        self.request = request;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.request.URL.host];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webView setDelegate:self];
    [self.webView setScalesPageToFit:YES];
    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor blackColor]];
    self.view = self.webView;
    
    [self.webView loadRequest:self.request];
}

#pragma mark - Webview Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([self getValueFromRequest:request withKey:@"code"]  ) {
        self.successBlock([self getValueFromRequest:request withKey:@"code"]);
        return NO;
    } else if ([self getValueFromRequest:request withKey:@"error"]) {
        self.failureBlock([NSError errorWithDomain:@"com.instructure.canvaskit" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Authentication failed. Most likely the user denied the request for access."}]);
        return NO;
    }
    
    return YES;
}

#pragma mark - OAuth Processing

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

- (void)cancelOAuth
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.failureBlock([NSError errorWithDomain:@"com.instructure.canvaskit" code:0 userInfo:@{NSLocalizedDescriptionKey: @"User cancelled authentication"}]);
    }];
}



@end
