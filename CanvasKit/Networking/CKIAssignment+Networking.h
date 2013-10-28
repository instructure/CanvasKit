//
//  CKIAssignment+Networking.h
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIAssignment.h"

@class CKIPagedResponse;

@interface CKIAssignment (Networking)

+ (void)fetchAssignmentsForCourse:(CKICourse *)course withSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
