//
//  CKILoginViewController.h
//  OAuthTesting
//
//  Created by rroberts on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKIClient;

@interface CKILoginViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;

/**
 Block to be performed when authentication is successful
 */
@property (nonatomic, copy) void (^successBlock)(NSString *oauthCode);

/**
 Block to be performed when authentication fails
 */
@property (nonatomic, copy) void (^failureBlock)(NSError *error);

- (id)initWithRequest:(NSURLRequest *)request;
- (void)cancelOAuth;

@end
