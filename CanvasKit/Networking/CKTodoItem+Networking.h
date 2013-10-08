//
//  CKTodoItem+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKTodoItem.h"
#import "CKCourse.h"

@class CKPagedResponse;

@interface CKTodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CKCourse *)course success:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;
+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
