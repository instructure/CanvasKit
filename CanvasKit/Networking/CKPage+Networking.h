//
//  CKPage+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKPage.h"

@class CKCourse;
@class CKPagedResponse;

@interface CKPage (Networking)
+ (void)fetchPagesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;
+ (void)fetchPage:(NSString *)id forCourse:(CKCourse *)course success:(void (^)(CKPage *page))success failure:(void (^)(NSError *error))failure;
@end
