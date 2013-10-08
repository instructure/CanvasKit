//
//  CKCourse+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKCourse.h"
#import "CKUser.h"

@class CKPagedResponse;

@interface CKCourse (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)fetchCourseUsersWithSuccess:(void(^)(NSArray *users))success failure:(void(^)(NSError *error))failure;
- (void)searchUsersMatchingString:(NSString *)matchingString success:(void(^)(NSArray *users))success failure:(void(^)(NSError *error))failure;

@end
