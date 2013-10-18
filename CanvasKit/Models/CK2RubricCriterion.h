//
//  CK2RubricCriterion.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CK2Model.h"

@class CK2RubricCriterionRating;

/**
 A rubric is made up of various criteria.
 
 For example, a criterion might be "Grammar" and have a score
 of 4 for a student. It may also have a list of pre-defined
 ratings the grader can use that were set up with the rubric.
 */
@interface CK2RubricCriterion : CK2Model

/**
 Points scored on this criterion.
 */
@property (nonatomic) double points;

/**
 Description of the criterion.
 */
@property (nonatomic, copy) NSString *descriptionText;

/**
 A more detailed description of the criterion.
 */
@property (nonatomic, copy) NSString *longDescription;

/**
 Array of CK2RubricCriterionRating for this criterion.
 */
@property (nonatomic, copy) NSArray *ratings;

/**
 The currently selected rating for this criterion, if any.
 */
@property (nonatomic, readonly) CK2RubricCriterionRating *selectedRating;

@end
