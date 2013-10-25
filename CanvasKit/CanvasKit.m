//
//  CanvasKit.m
//  CanvasKit
//
//  Created by Rick Roberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CanvasKit.h"

#import "CK2Client.h"
#import "CK2Client+Keychain.h"

@implementation CanvasKit

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret
{
    
    NSAssert(aClientId, @"You must provide a client id");
    NSAssert(aSharedSecret, @"You must provide a shared secret");
    
    CK2Client *sharedClient = [CK2Client currentClient];
    [sharedClient setClientId:aClientId];
    [sharedClient setSharedSecret:aSharedSecret];
    [sharedClient setAuthToken:[sharedClient.keychain objectForKey:kCK2KeychainAuthTokenKey]];
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId
{
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
    
    CK2Client *sharedClient = [CK2Client currentClient];
    [sharedClient setKeyChainId:aKeyChainId];
    [sharedClient setAuthToken:[sharedClient.keychain objectForKey:kCK2KeychainAuthTokenKey]];
}

@end
