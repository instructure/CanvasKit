//
//  CKIClient+CKIAssignment.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIAssignment.h"
#import "CKIAssignment.h"
#import "CKICourse.h"

@implementation CKIClient (CKIAssignment)

- (void)fetchAssignmentsForCourse:(CKICourse *)course withSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignments"];
    
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIAssignment class] context:course success:success failure:failure];
}

@end
