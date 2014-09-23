//
//  CKIClient+CKISubmissionRecord.m
//  CanvasKit
//
//  Created by Brandon Pluim on 9/5/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKISubmissionRecord.h"

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "CKIAssignment.h"
#import "CKISubmission.h"
#import "CKIRubricAssessment.h"

static const NSString *CKISubmissionHistory = @"submission_history";
static const NSString *CKISubmissionComments = @"submission_comments";
static const NSString *CKISubmissionRubricAssessment = @"rubric_assessment";

@implementation CKIClient (CKISubmissionRecord)

- (RACSignal *)fetchSubmissionRecordsForAssignment:(CKIAssignment *)assignment
{
    NSString *path = [assignment.path stringByAppendingPathComponent:@"submissions"];
    NSDictionary *parameters = @{@"include" : @[CKISubmissionHistory, CKISubmissionComments, CKISubmissionRubricAssessment]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKISubmissionRecord class] context:assignment];
}

- (RACSignal *)fetchSubmissionRecordsForAssignment:(CKIAssignment *)assignment forStudentWithID:(NSString *)studentID {
    NSString *path = [[assignment.path stringByAppendingPathComponent:@"submissions"] stringByAppendingPathComponent:studentID];
    NSDictionary *parameters = @{@"include" : @[CKISubmissionHistory, CKISubmissionComments, CKISubmissionRubricAssessment]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKISubmissionRecord class] context:assignment];
}

- (RACSignal *)updateGrade:(NSString *)gradeString forSubmissionRecord:(CKISubmissionRecord *)submission {
    return [self updateModel:submission parameters:@{@"submission": @{@"posted_grade": gradeString}}];
}

- (RACSignal *)updateGrade:(NSString *)gradeString assessment:(CKIRubricAssessment *)assessment forSubmissionRecord:(CKISubmissionRecord *)submission {
    return [self updateModel:submission parameters:@{@"submission": @{@"posted_grade": gradeString}}];
}

- (RACSignal *)updateRubricAssessment:(CKIRubricAssessment *)assessment forSubmissionRecord:(CKISubmissionRecord *)submission {
    return [self updateModel:submission parameters:[assessment parametersDictionary]];
}

- (RACSignal *)addComment:(NSString *)comment forSubmissionRecord:(CKISubmissionRecord *)submission {
    return [self updateModel:submission parameters:@{@"comment": @{@"text_comment": comment}}];
}

@end
