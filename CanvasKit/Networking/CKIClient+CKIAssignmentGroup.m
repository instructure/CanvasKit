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
#import "CKIRubricCriterion.h"
#import "CKIRubricCriterionRating.h"
#import "CKIEnrollment.h"

@implementation CKIClient (CKIAssignmentGroup)

- (RACSignal *)fetchAssignmentGroupsForContext:(id <CKIContext>)context
{
    return [self fetchAssignmentGroupsForContext:context includeAssignments:YES];
}

- (RACSignal *)fetchAssignmentGroupsForContext:(id <CKIContext>)context includeAssignments:(BOOL)includeAssignments
{
    NSString *path = [[context path] stringByAppendingPathComponent:@"assignment_groups"];

    // handle multiple grading periods
    NSString *gradingPeriodID = nil;
    if ([context isKindOfClass:[CKICourse class]]) {
        CKICourse *course = (CKICourse *)context;
        gradingPeriodID = [[[course.enrollments.rac_sequence filter:^BOOL(CKIEnrollment *enrollment) {
            return enrollment.multipleGradingPeriodsEnabled &&
                (enrollment.isStudent || enrollment.type == CKIEnrollmentTypeObserver);
        }] map:^id(CKIEnrollment *studentEnrollment) {
            return studentEnrollment.currentGradingPeriodID;
        }].array firstObject];
    }

    NSDictionary *parameters;
    if (!includeAssignments) {
        parameters = nil;
    } else if (!gradingPeriodID) {
        parameters = @{@"include": @[@"assignments"]};
    } else {
        parameters = @{
                          @"include" : @[@"assignments"],
                          @"grading_period_id": gradingPeriodID,
                          @"scope_assignments_to_student": @(YES)
                      };
    }

    return [[self fetchResponseAtPath:path parameters:parameters modelClass:[CKIAssignmentGroup class] context:context] map:^id(NSArray *assignmentGroups) {
        if (!includeAssignments) {
            return assignmentGroups;
        }
        
        for (CKIAssignmentGroup *group in assignmentGroups) {
            for (CKIAssignment *assignment in group.assignments) {
                assignment.context = context;
                
                // set properties on rubricCriterionRating for easy sorting/retrieval
                [assignment.rubricCriterion enumerateObjectsUsingBlock:^(CKIRubricCriterion *criterion, NSUInteger idx, BOOL *stop) {
                    criterion.position = idx;
                }];
            }
        }
        return assignmentGroups;
    }];
}

@end
