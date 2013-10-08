//
//  CKTab+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKTab.h"
#import "CKCourse.h"

@class CKPagedResponse;

@interface CKTab (Networking)

+ (void)fetchTabsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
