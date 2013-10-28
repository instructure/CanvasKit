//
//  CanvasKit.m
//  CanvasKit
//
//  Created by Rick Roberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CanvasKit.h"

#import "CKIClient.h"
#import "CKIClient+Keychain.h"

@implementation CanvasKit

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret
{
    
    NSAssert(aClientId, @"You must provide a client id");
    NSAssert(aSharedSecret, @"You must provide a shared secret");
    
    CKIClient *sharedClient = [CKIClient currentClient];
    [sharedClient setClientId:aClientId];
    [sharedClient setSharedSecret:aSharedSecret];
    [sharedClient setAuthToken:[sharedClient.keychain objectForKey:kCKIKeychainAuthTokenKey]];
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId
{
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
    
    CKIClient *sharedClient = [CKIClient currentClient];
    [sharedClient setKeyChainId:aKeyChainId];
    [sharedClient setAuthToken:[sharedClient.keychain objectForKey:kCKIKeychainAuthTokenKey]];
}

@end
