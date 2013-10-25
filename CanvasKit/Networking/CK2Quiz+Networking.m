//
//  CK2Quiz+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Quiz+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2Quiz (Networking)

+ (void)fetchQuiz:(NSString *)quizID forCourse:(CK2Course *)course success:(void (^)(CK2Quiz *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    path = [path stringByAppendingPathComponent:quizID];
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Quiz class] context:course success:(void (^)(CK2Model *quiz))success failure:failure];
}

+ (void)fetchQuizzesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"quizzes"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Quiz class] context:course success:success failure:failure];
}



@end
