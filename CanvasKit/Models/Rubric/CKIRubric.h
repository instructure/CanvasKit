//
// CKIRubric.h
// Created by Jason Larsen on 5/20/14.
//

#import <Foundation/Foundation.h>
#import "CKIModel.h"


/**
* Every assignment may have a rubric. The rubric is used as a template
* to standardize grading on an assignment. A rubric is composed of rubric
* criteria, and each individual criterion has several rating options, each
* option represented by a rating object.
*
* @see CKIRubricCriterion
* @see CKIRubricCriterionRating
*/
@interface CKIRubric : CKIModel

/**
* The title of the rubric.
*/
@property (nonatomic, copy) NSString *title;

/**
* An array of CKICriterion that compose the criteria for the rubric.
*
* @see CKIRubricCriterion
* @warning This property must be set with the criteria found in the "rubric" key
* on the assignment object. The API returns the rubric criteria and the settings
* in separate keys. Thus we must coalesce them into one object manually. CKIAssignment
* should handle this when it parses itself, given that it has a rubric.
*/
@property (nonatomic, copy) NSArray *criteria;

/**
* The total number of points possible.
*
* @note a submission may score over 100%, and therefore the actual points
* may be greater than pointsPossible.
*/
@property (nonatomic) double pointsPossible;

/**
* Indicates whether or not the grader should be presented with
* the option to include a special free-form comment along with
* the rating selection on a particular criterion.
*/
@property (nonatomic) BOOL allowsFreeFormCriterionComments;

@end