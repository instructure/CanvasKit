//
//  CK2LocalUser.h
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2User.h"

@interface CK2LocalUser : CK2User

/**
 Gets the local user singleton object
 */
+ (instancetype)sharedUser;

/**
 @return logged in status of user
 */
- (BOOL)isLoggedIn;

@end