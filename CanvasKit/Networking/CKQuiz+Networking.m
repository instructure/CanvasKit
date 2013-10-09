//
//  CKQuiz+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKQuiz+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKQuiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CKCourse *)course success:(void (^)(CKQuiz *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    path = [path stringByAppendingPathComponent:quizID];
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKQuiz class] context:course success:(void (^)(CKModel *quiz))success failure:failure];
}

+ (void)fetchQuizzesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKQuiz class] context:course success:success failure:failure];
}



@end
