//
//  CKAssignment+Networking.h
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKAssignment.h"

@class CKPagedResponse;

@interface CKAssignment (Networking)

- (void)fetchAssignmentsForCourse:(CKCourse *)course withSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
