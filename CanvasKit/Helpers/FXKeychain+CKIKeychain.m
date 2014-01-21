//
// Created by Jason Larsen on 1/15/14.
// Copyright (c) 2014 Instructure. All rights reserved.
//

#import "FXKeychain+CKIKeychain.h"
#import "CKIUser.h"

static const NSString *CKIKeychainAccessToken = @"CKIKeychainAccessToken";
static const NSString *CKIKeychainBaseURL = @"CKIKeychainBaseURL";
static const NSString *CKIKeychainCurrentUser = @"CKIKeychainCurrentUser";
static const NSString *CKIKeychainClientID = @"CKIKeychainClientID";
static const NSString *CKIKeychainClientSecret = @"CKIKeychainClientSecret";

@implementation FXKeychain (CBIKeychain)

- (NSString *)accessToken
{
    return self[CKIKeychainAccessToken];
}

- (void)setAccessToken:(NSString *)accessToken
{
    if (!accessToken) {
        if (self[CKIKeychainAccessToken]) {
            [self removeObjectForKey:CKIKeychainAccessToken];
        }
        return;
    }

    self[CKIKeychainAccessToken] = accessToken;
}

- (NSURL *)domain
{
    return [NSURL URLWithString:self[CKIKeychainBaseURL]];
}

- (void)setDomain:(NSURL *)domain
{
    if (!domain) {
        if (self[CKIKeychainBaseURL]) {
            [self removeObjectForKey:CKIKeychainBaseURL];
        }
        return;
    }

    self[CKIKeychainBaseURL] = domain.absoluteString;
}

- (CKIUser *)currentUser
{
    NSDictionary *dictionary = self[CKIKeychainCurrentUser];
    return [CKIUser modelFromJSONDictionary:dictionary];
}

- (void)setCurrentUser:(CKIUser *)currentUser
{
    if (!currentUser) {
        if (self[CKIKeychainCurrentUser]) {
            [self removeObjectForKey:CKIKeychainCurrentUser];
        }
        return;
    }

    NSDictionary *userDictionary = [currentUser JSONDictionary];
    self[CKIKeychainCurrentUser] = userDictionary;
}

- (NSString *)clientID
{
    return self[CKIKeychainClientID];
}

- (void)setClientID:(NSString *)clientID
{
    if (!clientID) {
        if (self[CKIKeychainClientID]) {
            [self removeObjectForKey:CKIKeychainClientID];
        }
        return;
    }

    self[CKIKeychainClientID] = clientID;
}

- (NSString *)clientSecret
{
    return self[CKIKeychainClientSecret];
}

- (void)setClientSecret:(NSString *)clientSecret
{
    if (!clientSecret) {
        if (self[CKIKeychainClientSecret]) {
            [self removeObjectForKey:CKIKeychainClientSecret];
        }
        return;
    }

    self[CKIKeychainClientSecret] = clientSecret;
}

@end