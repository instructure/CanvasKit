//
//  CKIClient+CKIGroup.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIGroup;
@class CKICourse;

@interface CKIClient (CKIGroup)

- (void)fetchGroup:(NSString *)groupID success:(void (^)(CKIGroup *group))success failure:(void (^)(NSError *error))failure;

- (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

- (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

- (void)fetchGroupsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
