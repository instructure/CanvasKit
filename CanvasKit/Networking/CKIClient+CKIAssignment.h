//
//  CKIClient+CKIAssignment.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;

@interface CKIClient (CKIAssignment)

- (void)fetchAssignmentsForCourse:(CKICourse *)course withSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
