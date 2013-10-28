//
//  CKIQuiz+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIQuiz+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIQuiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CKICourse *)course success:(void (^)(CKIQuiz *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    path = [path stringByAppendingPathComponent:quizID];
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course success:(void (^)(CKIModel *quiz))success failure:failure];
}

+ (void)fetchQuizzesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIQuiz class] context:course success:success failure:failure];
}



@end
