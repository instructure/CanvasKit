//
//  CKILocalUser.h
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIUser.h"

@interface CKILocalUser : CKIUser

/**
 Gets the local user singleton object
 */
+ (instancetype)sharedUser;

/**
 @return logged in status of user
 */
- (BOOL)isLoggedIn;

@end