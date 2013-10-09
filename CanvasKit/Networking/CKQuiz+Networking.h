//
//  CKQuiz+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKQuiz.h"

@class CKCourse;
@class CKPagedResponse;

@interface CKQuiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CKCourse *)course success:(void (^)(CKQuiz *quiz))success failure:(void (^)(NSError *error))failure;

+ (void)fetchQuizzesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;


@end
