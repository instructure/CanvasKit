//
//  CKClient+Keychain.h
//  CanvasKit
//
//  Created by derrick on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKClient.h"
#import <FXKeychain.h>

@interface CKClient (Keychain)
@property (nonatomic, readonly) FXKeychain *keychain;
@end
