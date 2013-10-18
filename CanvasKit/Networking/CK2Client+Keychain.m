//
//  CK2Client+Keychain.m
//  CanvasKit
//
//  Created by derrick on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Client+Keychain.h"

@implementation CK2Client (Keychain)
- (FXKeychain *)keychain
{
    if (self.keyChainId) {
        return [[FXKeychain alloc] initWithService:self.keyChainId accessGroup:self.keyChainId];
    }
    
    return [FXKeychain defaultKeychain];
}
@end
