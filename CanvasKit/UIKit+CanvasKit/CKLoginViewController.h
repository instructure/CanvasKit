//
//  CKLoginViewController.h
//  OAuthTesting
//
//  Created by rroberts on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CKOAuthSuccessBlock)(void);
typedef void (^CKOAuthFailureBlock)(NSError *error);

@interface CKLoginViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

/**
 Block to be performed when authentication is successful
 */
@property (nonatomic, strong) CKOAuthSuccessBlock oauthSuccessBlock;

/**
 Block to be performed when authentication fails
 */
@property (nonatomic, strong) CKOAuthFailureBlock oauthFailureBlock;

- (id)initWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;
- (void)cancelOAuth;


@end
