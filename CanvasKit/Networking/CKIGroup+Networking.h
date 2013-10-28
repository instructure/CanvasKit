//
//  CKIGroup+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIGroup.h"

@class CKICourse;
@class CKIPagedResponse;

@interface CKIGroup (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CKIGroup *group))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
