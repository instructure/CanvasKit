
//
//  CKIEnrollment.h
//  CanvasKit
//
//  Created by rroberts on 1/10/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIModel.h"

@interface CKIEnrollment : CKIModel

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *role;

@property (nonatomic, strong) NSNumber *computedFinalScore;

@property (nonatomic, strong) NSNumber *computedCurrentScore;

@property (nonatomic, strong) NSString *computedFinalGrade;

@property (nonatomic, strong) NSString *computedCurrentGrade;

@property (nonatomic, readonly) BOOL isStudent;
@end
