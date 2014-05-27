//
//  CKIClient+CKIAssignmentGroup.m
//  CanvasKit
//
//  Created by Miles Wright on 1/8/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIAssignmentGroup.h"
#import "CKIAssignmentGroup.h"
#import "CKIAssignment.h"
#import "CKICourse.h"

@implementation CKIClient (CKIAssignmentGroup)

- (RACSignal *)fetchAssignmentGroupsForContext:(id <CKIContext>)context
{
    NSString *path = [[context path] stringByAppendingPathComponent:@"assignment_groups"];
    NSDictionary *parameters = @{@"include" : @[@"assignments"]};
    return [[self fetchResponseAtPath:path parameters:nil modelClass:[CKIAssignmentGroup class] context:context] map:^id(NSArray *assignmentGroups) {
        for (CKIAssignmentGroup *group in assignmentGroups) {
            for (CKIAssignment *assignment in group.assignments) {
                assignment.context = context;
            }
        }
        return assignmentGroups;
    }];
}

@end
