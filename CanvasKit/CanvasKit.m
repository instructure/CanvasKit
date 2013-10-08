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
    CKClient *sharedClient = [CKClient sharedClient];
    [sharedClient setClientId:aClientId];
    [sharedClient setSharedSecret:aSharedSecret];
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret domain:(NSString *)aDomain
{
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret];
    
    CKClient *sharedClient = [CKClient sharedClient];
    [sharedClient setDomain:aDomain];
}

+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret domain:(NSString *)aDomain keyChainId:(NSString *)aKeyChainId
{
    [CanvasKit prepareWithClientID:aClientId sharedSecret:aSharedSecret domain:aDomain];
    
    CKClient *sharedClient = [CKClient sharedClient];
    [sharedClient setKeyChainId:aKeyChainId];
}

@end
