//
//  CKIClient+CKIAssignment.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIAssignment.h"
#import "CKIAssignment.h"
#import "CKICourse.h"

@implementation CKIClient (CKIAssignment)

- (RACSignal *)fetchAssignmentsForContext:(id<CKIContext>)context
{
    NSString *path = [[context path] stringByAppendingPathComponent:@"assignments"];
    return [self fetchResponseAtPath:path parameters:@{@"include": @[@"submission"]} modelClass:[CKIAssignment class] context:context];
}

- (RACSignal *)fetchAssignmentsForCourse:(CKICourse *)course
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignments"];
    return [self fetchResponseAtPath:path parameters:@{@"include": @[@"submission"]} modelClass:[CKIAssignment class] context:course];
}

@end