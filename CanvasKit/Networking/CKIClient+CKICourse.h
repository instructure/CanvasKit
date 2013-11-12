//
//  CKIClient+CKICourse.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@interface CKIClient (CKICourse)

- (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

@end
