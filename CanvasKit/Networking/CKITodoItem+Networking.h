//
//  CKITodoItem+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITodoItem.h"
#import "CKICourse.h"

@class CKIPagedResponse;

@interface CKITodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CKICourse *)course success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;
+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
