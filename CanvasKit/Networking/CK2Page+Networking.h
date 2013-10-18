//
//  CK2Page+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Page.h"

@class CK2Course;
@class CK2PagedResponse;

@interface CK2Page (Networking)
+ (void)fetchPagesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;
+ (void)fetchPage:(NSString *)id forCourse:(CK2Course *)course success:(void (^)(CK2Page *page))success failure:(void (^)(NSError *error))failure;
@end
