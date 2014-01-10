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

- (RACSignal *)fetchAssignmentGroupsForCourse:(CKICourse *)course
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignment_groups"];
    return [[self fetchResponseAtPath:path parameters:@{@"include": @[@"assignments", @"all_dates", @"discussion_topic"]} modelClass:[CKIAssignmentGroup class] context:course] map:^id(NSArray *assignmentGroups) {
        for (CKIAssignmentGroup *group in assignmentGroups) {
            for (CKIAssignment *assignment in group.assignments) {
                assignment.context = course;
            }
        }
        return assignmentGroups;
    }];
}

@end
