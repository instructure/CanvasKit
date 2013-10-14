//
//  CanvasKit.m
//  CanvasKit
//
//  Created by Rick Roberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CanvasKit.h"

#import "CKClient.h"

@implementation CanvasKit

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret
{
    
    NSAssert(aClientId, @"You must provide a client id");
    NSAssert(aSharedSecret, @"You must provide a shared secret");
    
    CKClient *sharedClient = [CKClient sharedClient];
    [sharedClient setClientId:aClientId];
    [sharedClient setSharedSecret:aSharedSecret];
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId
{
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
    
    CKClient *sharedClient = [CKClient sharedClient];
    [sharedClient setKeyChainId:aKeyChainId];
}

@end
