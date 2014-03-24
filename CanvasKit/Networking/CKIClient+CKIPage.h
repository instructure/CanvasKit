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
@class RACSignal;

@interface CKIClient (CKIPage)

- (RACSignal *)fetchPagesForCourse:(CKICourse *)course;

- (RACSignal *)fetchPage:(NSString *)id forCourse:(CKICourse *)course;

- (RACSignal *)fetchPagesForContext:(id<CKIContext>)context;

- (RACSignal *)fetchPage:(NSString *)pageId forContext:(id<CKIContext>)context;

@end
