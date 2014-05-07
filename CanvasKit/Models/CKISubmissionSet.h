//
// CKISubmissionSet.h
// Created by Jason Larsen on 5/6/14.
//

#import <Foundation/Foundation.h>
#import "CKIModel.h"

@class CKISubmission;

/**
* The CKISubmissionSet represents the set of submissions from one
* user for one specific assignment.
*
* The CKISubmissionSet object does not exist in the API. To read more
* about how the API works, read the documentation in CKIClient+CKISubmissionSet.h
*/
@interface CKISubmissionSet : CKIModel

/**
* @note This property is a little different than on other models,
*       it is derived from the user_id key since SubmissionSets
*       are not a proper canvas object.
*/
@property (nonatomic, copy) NSString *id;

/**
* An array of CKISubmissions history of submissions for this particular
* user on this particular assignment, in order of least to most recent.
*/
@property (nonatomic, copy) NSArray *submissions;

/**
* The ID of the user that authored the submissions.
* (alias for id)
*/
@property (nonatomic, copy) NSString *userID;

/**
* The most recent submission in the submission set.
*/
@property (nonatomic, strong) CKISubmission *mostRecentSubmission;

@end