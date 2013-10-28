//
//  CKIQuiz+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKIQuiz+Networking.h"
#import "CKIQuiz.h"
#import "CKICourse.h"

SPEC_BEGIN(CKIQuiz_NetworkingSpec)

[CKIClient useTestClient];

describe(@"A CKIQuiz", ^{
    id course = [CKICourse mock];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/1"];
    
    context(@"when fetching a quiz", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes/2";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIQuiz fetchQuiz:@"2" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching quizzes for a course", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIQuiz fetchQuizzesForCourse:course success:nil failure:nil];
        });
    });
});


SPEC_END