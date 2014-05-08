//
//  CKISubmissionSet.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel.h"

extern NSString * const CKISubmissionTypeOnlineTextEntry;
extern NSString * const CKISubmissionTypeOnlineURL;
extern NSString * const CKISubmissionTypeOnlineUpload;
extern NSString * const CKISubmissionTypeMediaRecording;

@class CKIAssignment;

@interface CKISubmission : CKIModel

/**
 The ID of the assignment this is a submission for.
 */
@property (nonatomic, copy) NSString *assignmentID;

/**
 The attempt number of this submission.
 
 Ex: 4 would indicate that this is the 4th submission
 */
@property (nonatomic) NSUInteger attempt;

/**
 The content of a sumbission if submitted from a text field.
 */
@property (nonatomic, copy) NSString *body;

/**
 The grade for the submission, translated into the assignment
 grading scheme (so a letter grade, for example).
 
 @warning Because you don't have the grading scheme, you
 should not attempt to calculate this string yourself using
 the raw score property.
 
 @see score
 */
@property (nonatomic, copy) NSString *grade;


/**
 False if the student has re-submitted since the submission
 was last graded
 
 @see grade
 */
@property (nonatomic) BOOL gradeMatchesCurrentSubmission;

/**
 The URL of submission if it was a URL submission.
 
 @see CKISubmissionTypeOnlineURL
 */
@property (nonatomic, strong) NSURL *url;

/**
 The URL of the submission in web Canvas.
 */
@property (nonatomic, strong) NSURL *htmlURL;

/**
 The URL of the submission preview.
 */
@property (nonatomic, strong) NSURL *previewURL;

/**
 The raw score of this submission.
 */
@property (nonatomic) double score;

/**
 The date the submission was submitted.
 */
@property (nonatomic, strong) NSDate *submittedAt;

/**
 The type of submission.
 
 @see CKISubmissionTypeOnlineTextEntry, CKISubmissionTypeOnlineURL,
 CKISubmissionTypeOnlineUpload, CKISubmissionTypeMediaRecording
 */
@property (nonatomic, copy) NSString *submissionType;

/**
 The ID of the user that created the submission.
 */
@property (nonatomic, copy) NSString *userID;

/**
 The ID of the user that graded the submission.
 */
@property (nonatomic, copy) NSString *graderID;

/**
 The submission was made after the due date.
 */
@property (nonatomic) BOOL late;

/**
 Comments left by graders. An array of CKISubmissionComment objects.
 */
@property (nonatomic, copy) NSArray *comments;

/**
 When a submission appears in a conversation, the assignment is also
 available as part of the submission.
 */
@property (nonatomic) CKIAssignment *assignment;

/**
* Any file attachments included with this submission.
* Each attachment is a CKIFile object.
*/
@property (nonatomic, copy) NSArray *attachments;
@end
