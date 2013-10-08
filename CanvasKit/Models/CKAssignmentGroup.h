//
//  CKAssignmentGroup.h
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKAssignmentGroup : CKModel

/**
 The name of the Assignment Group
 */
@property (nonatomic, strong) NSString *name;

/**
 The position of the Assignment Group
 */
@property (nonatomic) NSInteger position;

/**
 The weight of the Assignment Group
 */
@property (nonatomic) NSInteger groupWeight;

/**
 The assignments in this Assignment Group
 @see CKAssignment
 */
@property (nonatomic, strong) NSArray *assignments;

/**
 The grading rules that this Assignment Group has
 */
@property (nonatomic, strong) NSDictionary *rules;

@end
