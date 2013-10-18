//
//  CK2TodoItem+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2TodoItem.h"
#import "CK2Course.h"

@class CK2PagedResponse;

@interface CK2TodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CK2Course *)course success:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;
+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
