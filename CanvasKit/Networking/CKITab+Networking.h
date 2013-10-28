//
//  CKITab+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITab.h"
#import "CKICourse.h"

@class CKIPagedResponse;

@interface CKITab (Networking)

+ (void)fetchTabsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
