//
//  CK2Quiz+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Quiz.h"

@class CK2Course;
@class CK2PagedResponse;

@interface CK2Quiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CK2Course *)course success:(void (^)(CK2Quiz *quiz))success failure:(void (^)(NSError *error))failure;

+ (void)fetchQuizzesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;


@end
