//
//  CKUser+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKUser.h"

@class CKPagedResponse;
@class CKCourse;

@interface CKUser (Networking)

+ (void)fetchUsersForCourse:(CKCourse *)course success:(void(^)(CKPagedResponse *users))success failure:(void(^)(NSError *error))failure;

@end
