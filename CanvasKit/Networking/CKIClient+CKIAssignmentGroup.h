//
//  CKIClient+CKIAssignmentGroup.h
//  CanvasKit
//
//  Created by Miles Wright on 1/8/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class RACSignal;

@interface CKIClient (CKIAssignmentGroup)

- (RACSignal *)fetchAssignmentGroupsForCourse:(CKICourse *)course;

@end
