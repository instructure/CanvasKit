//
//  CK2Course+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Course.h"
#import "CK2User.h"

@class CK2PagedResponse;

@interface CK2Course (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure;

@end
