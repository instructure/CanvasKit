//
//  CKModuleItem.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

/**
 The module item is a file.
 
 @see CKFile
 */
extern NSString * const CKModuleItemTypeFile;

/**
 The module item is a page.
 
 @see CKPage
 */
extern NSString * const CKModuleItemTypePage;

/**
 The module item is a dicussion.
 
 @see CKDicussion
 */
extern NSString * const CKModuleItemTypeDiscussion;

/**
 The module item is an assignment.
 
 @see CKAssignment
 */
extern NSString * const CKModuleItemTypeAssignment;

/**
 The module item is a quiz.
 
 @see CKQuiz.
 */
extern NSString * const CKModuleItemTypeQuiz;

/**
 The module item is a text subheader describing a subsection
 in a module.
 */
extern NSString * const CKModuleItemTypeSubHeader;

/**
 The module item is a URL to another web page.
 */
extern NSString * const CKModuleItemTypeExternalURL;

/**
 The module item is a URL to an LTI tool.
 */
extern NSString * const CKModuleItemTypeExternalTool;

/**
 Must view the item to fulfill completion requirement.
 */
extern NSString * const CKModuleItemCompletionRequirementMustView;
/**
 Must make a submission to fulfill completion requirement.
 */
extern NSString * const CKModuleItemCompletionRequirementMustSubmit;
/**
 Must contribute to fulfill completion requirement.
 */
extern NSString * const CKModuleItemCompletionRequirementMustContribute;
/**
 Must achieve a minimum score to fulfill completion requirement.
 
 @see minimumScore
 */
extern NSString * const CKModuleItemCompletionRequirementMinimumScore;

/**
 An individual item inside a CKModule. Can be a file, wiki page,
 discussion, assignment, quiz, text subheader, external URL, or
 external LTI tool.
 */
@interface CKModuleItem : CKModel

/**
 The title of the item.
 */
@property (nonatomic, copy) NSString *title;

/**
 The type of the item: File, Page, Discussion, Assignment,
 Quiz, SubHeader, ExternalUrl, or ExternalTool.
 */
@property (nonatomic, copy) NSString *type;

/**
 The ID of the object referred to, unless it is an external URL,
 external tool, or subheader.
 
 @see external_url for external tools and URLs.
 @note Subheaders do not have IDs; they are just a title.
 */
@property (nonatomic, readonly) NSString *itemID;

/**
 Link to the item's web page in Canvas.
 */
@property (nonatomic, strong) NSURL *htmlURL;

/**
 Link to the item's web API URL.
 */
@property (nonatomic, strong) NSURL *apiURL;

/**
 The URL of the external LTI tool or URL.
 */
@property (nonatomic, strong) NSURL *externalURL;

#pragma mark - Completion requirements

/**
 The requirement to complete this module item, if any: must either
 view the item, make a submission, contribute, or achieve a minimum
 score.
 
 @see CKModuleItemCompletionRequirementMustView
 CKModuleItemCompletionRequirementMustSubmit
 CKModuleItemCompletionRequirementMustContribute
 CKModuleItemCompletionRequirementMinimumScore
 @see minimumScore if this is a CKModuleItemCompletionRequirementMinimumScore
 */
@property (nonatomic, copy) NSString *completionRequirement;

/**
 The minimum score that must be achieved to complete this item.
 
 @note Only present if completionRequirement is of type
 CKModuleItemCompletionRequirementMinimumScore
 
 @see completionRequirement
 */
@property (nonatomic) double minimumScore;

/**
 This module item's completion requirement has been met.
 
 @see completionRequirement
 @warning This is only valid if there is a completion requirement. Some
 items have no completion requirements, and therefore are neither completed,
 nor incomplete.
 */
@property (nonatomic) BOOL completed;

@end