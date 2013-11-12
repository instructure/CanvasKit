//
//  CKIClient+CKITab.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKITab;
@class CKICourse;

@interface CKIClient (CKITab)

- (void)fetchTabsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
