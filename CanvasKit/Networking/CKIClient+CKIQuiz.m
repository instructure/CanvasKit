//
//  CKIClient+CKIQuiz.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIQuiz.h"
#import "CKIQuiz.h"
#import "CKICourse.h"

@implementation CKIClient (CKIQuiz)

- (void)fetchQuiz:(NSString *)quizID forCourse:(CKICourse *)course success:(void (^)(CKIQuiz *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    path = [path stringByAppendingPathComponent:quizID];
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course success:(void (^)(CKIModel *quiz))success failure:failure];
}

- (void)fetchQuizzesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course success:success failure:failure];
}

@end
