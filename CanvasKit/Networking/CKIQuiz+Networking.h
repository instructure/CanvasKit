//
//  CKIQuiz+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIQuiz.h"

@class CKICourse;
@class CKIPagedResponse;

@interface CKIQuiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CKICourse *)course success:(void (^)(CKIQuiz *quiz))success failure:(void (^)(NSError *error))failure;

+ (void)fetchQuizzesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;


@end
