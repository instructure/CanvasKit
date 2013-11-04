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
    
    NSURL *domain = [NSURL URLWithString:[keychain objectForKey:kCKIKeychainDomainKey]];
    if (domain) {
        [self setCurrentDomain:domain];
    }
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId
{
    keychainID = aKeyChainId;
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
}

+ (void)setCurrentDomain:(NSURL *)currentDomain
{
    CKIClient *client = [CKIClient clientWithBaseURL:currentDomain];
    
    client.sharedSecret = sharedSecret;
    client.clientId = clientID;
    client.keyChainId = keychainID;
    client.authToken = [client.keychain objectForKey:kCKIKeychainAuthTokenKey];
    
    [CKIClient setCurrentClient:client];
}

@end
