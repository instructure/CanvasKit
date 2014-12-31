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

@implementation CKIClient (CKIAssignmentGroup)

- (RACSignal *)fetchAssignmentGroupsForContext:(id <CKIContext>)context
{
    [self fetchAssignmentGroupsForContext:context includeAssignments:YES];
}

- (RACSignal *)fetchAssignmentGroupsForContext:(id <CKIContext>)context includeAssignments:(BOOL)includeAssignments
{
    NSString *path = [[context path] stringByAppendingPathComponent:@"assignment_groups"];
    NSDictionary *parameters = includeAssignments ? @{@"include" : @[@"assignments"]} : nil;
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
