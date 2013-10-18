//
//  CK2LoginViewController.h
//  OAuthTesting
//
//  Created by rroberts on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CK2OAuthSuccessBlock)(void);
typedef void (^CK2OAuthFailureBlock)(NSError *error);

@interface CK2LoginViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;

/**
 Block to be performed when authentication is successful
 */
@property (nonatomic, strong) CK2OAuthSuccessBlock oauthSuccessBlock;

/**
 Block to be performed when authentication fails
 */
@property (nonatomic, strong) CK2OAuthFailureBlock oauthFailureBlock;

/**
 Domain used for authentication
 */
@property (nonatomic, strong) NSString *domain;

- (id)initWithDomain:(NSString *)domain success:(void(^)(void))success failure:(void(^)(NSError *error))failure;
- (void)cancelOAuth;


@end
