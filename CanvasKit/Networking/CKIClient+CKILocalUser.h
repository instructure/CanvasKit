//
//  CKIClient+CKILocalUser.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@interface CKIClient (CKILocalUser)

/**
 Call to update user attributes from API
 
 @warning The user must be authenticated before performing this action
 */
- (void)fetchLocalUserAttributesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 Starts the OAuth2 authentication process. The user will be aksed to login to Canvas. Once logged in the user will have the option to allow the app to authenticate via Canvas.
 
 @warning CanvasKit must be prepared for OAuth2 before this method is called.
 @see CanvasKit.h
 */
- (void)performLoginWithDomain:(NSString *)domain success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 Fetches the activity stream for the current user.
 
 @param success success block returning a paged response
 @param failure failure block for handling error
 */
- (void)fetchActivityStreamWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
