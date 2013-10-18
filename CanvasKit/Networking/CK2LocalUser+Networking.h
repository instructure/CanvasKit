//
//  CK2LocalUser+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2LocalUser.h"

@interface CK2LocalUser (Networking)

/**
 Call to update user attributes from API
 
 @warning The user must be authenticated before performing this action
 */
- (void)fetchAttributesWithsuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 Starts the OAuth2 authentication process. The user will be aksed to login to Canvas. Once logged in the user will have the option to allow the app to authenticate via Canvas.
 
 @warning CanvasKit must be prepared for OAuth2 before this method is called.
 @see CanvasKit.h
 */
- (void)performLoginWithDomain:(NSString *)domain success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end
