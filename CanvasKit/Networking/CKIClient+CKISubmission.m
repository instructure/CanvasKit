//
//  CKIClient+CKISubmission.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "CKIClient+CKISubmission.h"
#import "CKIAssignment.h"
#import "CKISubmission.h"

static const NSString *CKISubmissionHistory = @"submission_history";
static const NSString *CKISubmissionComments = @"submission_comments";
static const NSString *CKISubmissionRubricAssessment = @"rubric_assessment";


@implementation CKIClient (CKISubmission)

- (RACSignal *)fetchSubmissionsForAssignment:(CKIAssignment *)assignment
{
    NSString *path = [assignment.path stringByAppendingPathComponent:@"submissions"];
    NSDictionary *parameters = @{@"include" : @[CKISubmissionHistory, CKISubmissionComments, CKISubmissionRubricAssessment]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKISubmission class] context:assignment];
}


@end
