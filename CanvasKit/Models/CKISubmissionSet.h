//
// CKISubmissionSet.h
// Created by Jason Larsen on 5/6/14.
//

#import <Foundation/Foundation.h>
#import "CKIModel.h"

@class CKISubmission;

@interface CKISubmissionSet : CKIModel

/**
* @note This property is a little different than on other models,
*       it is derived from the user_id key since SumbissionSets
*       are not a proper canvas object.
*/
@property (nonatomic, copy) NSString *id;

/**
* An array of CKISubmissions history of submissions for this particular
* user on this particular assignment, in order of least to most recent.
*/
@property (nonatomic, copy) NSArray *submissions;

/**
* The most recent submission in the submission set.
*/
@property (nonatomic, strong) CKISubmission *mostRecentSubmission;

@end