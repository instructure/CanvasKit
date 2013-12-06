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

- (RACSignal *)fetchTodoItemsForCourse:(CKICourse *)course
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"todo"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:course];
}

- (RACSignal *)fetchTodoItemsForCurrentUser
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/todo"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:nil];
}

@end
