//
//  CKIClient+CKIQuiz.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIQuiz;
@class CKICourse;

@interface CKIClient (CKIQuiz)

- (void)fetchQuiz:(NSString *)quizID forCourse:(CKICourse *)course success:(void (^)(CKIQuiz *quiz))success failure:(void (^)(NSError *error))failure;

- (void)fetchQuizzesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
