//
//  CKLocalUser.m
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKLocalUser.h"
#import "CanvasKit.h"
#import "CKLoginViewController.h"
#import "CKClient+Keychain.h"

@implementation CKLocalUser

+ (instancetype)sharedUser {
    static CKLocalUser *_sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUser = [[CKLocalUser alloc] init];
    });
    
    return _sharedUser;
}

- (BOOL)isLoggedIn
{
    return [[CKClient sharedClient].keychain objectForKey:kCKKeychainAuthTokenKey] != nil;
}

- (NSString *)path
{
    NSString *path = [self.context.path stringByAppendingPathComponent:@"users/self"];
    return path;
}

@end









