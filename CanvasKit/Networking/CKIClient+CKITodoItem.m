//
//  CKIClient+CKITodoItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKITodoItem.h"
#import "CKITodoItem.h"
#import "CKICourse.h"

@implementation CKIClient (CKITodoItem)

- (void)fetchTodoItemsForCourse:(CKICourse *)course success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"todo"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:course success:success failure:failure];
}

- (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/todo"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:nil success:success failure:failure];
}

@end
