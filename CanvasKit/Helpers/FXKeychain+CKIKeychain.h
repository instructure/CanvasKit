//
// Created by Jason Larsen on 1/15/14.
// Copyright (c) 2014 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXKeychain.h"

@class CKIUser;

@interface FXKeychain (CKIKeychain)
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) CKIUser *currentUser;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@end