//
//  CKICourse+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKICourse.h"
#import "CKIUser.h"

@class CKIPagedResponse;

@interface CKICourse (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

@end
