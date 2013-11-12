//
//  CKIClient+CKIPage.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class CKIPage;

@interface CKIClient (CKIPage)

- (void)fetchPagesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

- (void)fetchPage:(NSString *)id forCourse:(CKICourse *)course success:(void (^)(CKIPage *page))success failure:(void (^)(NSError *error))failure;

@end
