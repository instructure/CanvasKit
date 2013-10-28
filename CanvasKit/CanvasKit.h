//
//  CanvasKit.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKIUser.h"
#import "CKILocalUser.h"
#import "Constants.h"

@interface CanvasKit : NSObject

/**
 Prepares the shared client for OAuth2 authentication. Preparing the CKIClient for authentication with this method will not prompt the user for a domain.
 
 @param OAuth2 client id
 @param OAuth2 shared secret
 
 @warning If the domain is invalidated the login process will fail.
 */
+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret;

/**
 Prepares the shared client for OAuth2 authentication. Use this preparation method if you would like to store the authentication token in your keychain.
 
 @param OAuth2 client id
 @param OAuth2 shared secret
 @param application keychain ID
 */
+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId;

/**
 Set the current base URL for the canvas instance you want to work with. Ex: http://canvas.instructure.com
 
 @param currentDomain the domain/subdomains where you want to be hitting the APIs
 @warning if you don't call one of the prepareWithClientID methods first, you're gonna have a bad time.
 */
+ (void)setCurrentDomain:(NSURL *)currentDomain;

@end