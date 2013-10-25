//
//  CK2LocalUser.m
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2LocalUser.h"
#import "CanvasKit.h"
#import "CK2LoginViewController.h"
#import "CK2Client+Keychain.h"

@implementation CK2LocalUser

+ (instancetype)sharedUser {
    static CK2LocalUser *_sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUser = [[CK2LocalUser alloc] init];
    });
    
    return _sharedUser;
}

- (BOOL)isLoggedIn
{
    return [[CK2Client currentClient].keychain objectForKey:kCK2KeychainAuthTokenKey] != nil;
}

- (NSString *)path
{
    NSString *path = [self.context.path stringByAppendingPathComponent:@"users/self"];
    return path;
}

@end









