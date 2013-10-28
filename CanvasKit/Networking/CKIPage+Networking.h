//
//  CKIPage+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIPage.h"

@class CKICourse;
@class CKIPagedResponse;

@interface CKIPage (Networking)
+ (void)fetchPagesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;
+ (void)fetchPage:(NSString *)id forCourse:(CKICourse *)course success:(void (^)(CKIPage *page))success failure:(void (^)(NSError *error))failure;
@end
