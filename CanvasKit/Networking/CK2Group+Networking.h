//
//  CK2Group+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Group.h"

@class CK2Course;
@class CK2PagedResponse;

@interface CK2Group (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CK2Group *group))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

+ (void)fetchGroupsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
