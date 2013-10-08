//
//  CKLocalUser.h
//  CanvasKit
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKUser.h"

@interface CKLocalUser : CKUser

/**
 Gets the local user singleton object
 */
+ (instancetype)sharedUser;

/**
 @return logged in status of user
 */
- (BOOL)isLoggedIn;

@end