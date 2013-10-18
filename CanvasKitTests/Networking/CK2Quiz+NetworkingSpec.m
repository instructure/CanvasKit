//
//  CK2Quiz+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Quiz+Networking.h"
#import "CK2Quiz.h"
#import "CK2Course.h"

SPEC_BEGIN(CK2Quiz_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2Quiz", ^{
    id course = [CK2Course mock];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/1"];
    
    context(@"when fetching a quiz", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes/2";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Quiz fetchQuiz:@"2" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching quizzes for a course", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Quiz fetchQuizzesForCourse:course success:nil failure:nil];
        });
    });
});


SPEC_END