//
//  CKIClient+Keychain.h
//  CanvasKit
//
//  Created by derrick on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"


@interface CKIClient (Keychain)
@property (nonatomic, readonly) FXKeychain *keychain;
@end
