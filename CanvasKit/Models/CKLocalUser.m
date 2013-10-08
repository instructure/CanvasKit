//
//  CKLocalUser.m
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKLocalUser.h"
#import "CanvasKit.h"
#import "CKClient.h"
#import "CKLoginViewController.h"
#import <FXKeychain/FXKeychain.h>

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
    FXKeychain *keyChain = [[FXKeychain alloc] initWithService:[CKClient sharedClient].keyChainId accessGroup:[CKClient sharedClient].keyChainId];
    return [[keyChain objectForKey:kCKKeychainAuthTokenKey] boolValue];
}

- (NSString *)path
{
    NSString *path = [self.context.path stringByAppendingPathComponent:@"users/self"];
    return path;
}

@end









