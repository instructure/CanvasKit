//
// Created by Jason Larsen on 1/15/14.
// Copyright (c) 2014 Instructure. All rights reserved.
//

#import "FXKeychain+CKIKeychain.h"
#import "CKIUser.h"

static const NSString *CKIKeychainOAuthTokenName = @"CKIKeychainOAuthToken";
static const NSString *CKIKeychainDomainName = @"CKIKeychainDomain";
static const NSString *CKIKeychainCurrentUserName = @"CKIKeychainCurrentUserName";
static const NSString *CKIKeychainClientIDName = @"CKIKeychainClientIDName";
static const NSString *CKIKeychainClientSecretName = @"CKIKeychainClientSecretName";

@implementation FXKeychain (CBIKeychain)

- (NSString *)oauthToken
{
    return self[CKIKeychainOAuthTokenName];
}

- (void)setOauthToken:(NSString *)oauthToken
{
    if (!oauthToken) {
        if (self[CKIKeychainOAuthTokenName]) {
            [self removeObjectForKey:CKIKeychainOAuthTokenName];
        }
        return;
    }

    self[CKIKeychainOAuthTokenName] = oauthToken;
}

- (NSURL *)domain
{
    return [NSURL URLWithString:self[CKIKeychainDomainName]];
}

- (void)setDomain:(NSURL *)domain
{
    if (!domain) {
        if (self[CKIKeychainDomainName]) {
            [self removeObjectForKey:CKIKeychainDomainName];
        }
        return;
    }

    self[CKIKeychainDomainName] = domain.absoluteString;
}

- (CKIUser *)currentUser
{
    NSDictionary *dictionary = self[CKIKeychainCurrentUserName];
    return [CKIUser modelFromJSONDictionary:dictionary];
}

- (void)setCurrentUser:(CKIUser *)currentUser
{
    if (!currentUser) {
        if (self[CKIKeychainCurrentUserName]) {
            [self removeObjectForKey:CKIKeychainCurrentUserName];
        }
        return;
    }

    NSDictionary *userDictionary = [currentUser JSONDictionary];
    self[CKIKeychainCurrentUserName] = userDictionary;
}

- (NSString *)clientID
{
    return self[CKIKeychainClientIDName];
}

- (void)setClientID:(NSString *)clientID
{
    if (!clientID) {
        if (self[CKIKeychainClientIDName]) {
            [self removeObjectForKey:CKIKeychainClientIDName];
        }
        return;
    }

    self[CKIKeychainClientIDName] = clientID;
}

- (NSString *)clientSecret
{
    return self[CKIKeychainClientSecretName];
}

- (void)setClientSecret:(NSString *)clientSecret
{
    if (!clientSecret) {
        if (self[CKIKeychainClientSecretName]) {
            [self removeObjectForKey:CKIKeychainClientSecretName];
        }
        return;
    }

    self[CKIKeychainClientSecretName] = clientSecret;
}

@end