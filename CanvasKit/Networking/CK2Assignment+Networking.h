//
//  CK2Assignment+Networking.h
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Assignment.h"

@class CK2PagedResponse;

@interface CK2Assignment (Networking)

+ (void)fetchAssignmentsForCourse:(CK2Course *)course withSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
