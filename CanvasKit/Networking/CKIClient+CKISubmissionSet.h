//
//  CKIClient+CKISubmissionSet.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIAssignment;

@interface CKIClient (CKISubmissionSet)

/**
* Fetches the submission sets for the specified the assignment.
*
* The SubmissionSet object does not exist in the API. The submissions
* API actually returns an array of the most recent submission per user
* by default. By including the submission_history flag, the API will
* actually return an array of all submissions submitted by the user,
* nested as an array of dictionaries inside the most recent submission,
* which is the submission object return by the API. Since the submission_history
* array happens to contain the most recent submission object as well, we
* ignore the top level submission and instead focus on the submission_history
* array which has all the information we need. The CKISubmissionSet object
* is the object that wraps around this array of submissions, essentially
* grouping together all the submissions for a particular user on the
* specified assignment.
*/
- (RACSignal *)fetchSubmissionSetsForAssignment:(CKIAssignment *)assignment;

@end
