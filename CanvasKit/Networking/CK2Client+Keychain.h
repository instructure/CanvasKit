//
//  CK2Client+Keychain.h
//  CanvasKit
//
//  Created by derrick on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Client.h"
#import <FXKeychain.h>

@interface CK2Client (Keychain)
@property (nonatomic, readonly) FXKeychain *keychain;
@end
