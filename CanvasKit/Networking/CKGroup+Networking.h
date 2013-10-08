//
//  CKGroup+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKGroup.h"

@class CKCourse;
@class CKPagedResponse;

@interface CKGroup (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CKGroup *group))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
