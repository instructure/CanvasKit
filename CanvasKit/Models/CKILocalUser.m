//
//  CKILocalUser.m
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKILocalUser.h"
#import "CanvasKit.h"
#import "CKILoginViewController.h"
#import "CKIClient+Keychain.h"

@implementation CKILocalUser

+ (instancetype)sharedUser {
    static CKILocalUser *_sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUser = [[CKILocalUser alloc] init];
    });
    
    return _sharedUser;
}

- (BOOL)isLoggedIn
{
    return [[CKIClient currentClient].keychain objectForKey:kCKIKeychainAuthTokenKey] != nil;
}

- (NSString *)path
{
    NSString *path = [self.context.path stringByAppendingPathComponent:@"users/self"];
    return path;
}

@end









