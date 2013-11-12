//
//  CanvasKit.m
//  CanvasKit
//
//  Created by Rick Roberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CanvasKit.h"
#import <FXKeychain/FXKeychain.h>

#import "CKIClient.h"

static NSString *clientID;
static NSString *sharedSecret;
static NSString *keychainID;

@implementation CanvasKit

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret
{
    NSAssert(aClientId, @"You must provide a client id");
    NSAssert(aSharedSecret, @"You must provide a shared secret");
    
    FXKeychain *keychain;
    if (keychainID) {
        keychain = [[FXKeychain alloc] initWithService:keychainID accessGroup:nil];
    } else {
        keychain = [FXKeychain defaultKeychain];
    }
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId
{
    keychainID = aKeyChainId;
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
}


@end
