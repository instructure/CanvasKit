//
//  CKQuiz+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKQuiz+Networking.h"
#import "CKQuiz.h"
#import "CKCourse.h"

SPEC_BEGIN(CKQuiz_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKQuiz", ^{
    id course = [CKCourse mock];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/1"];
    
    context(@"when fetching a quiz", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes/2";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKQuiz fetchQuiz:@"2" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching quizzes for a course", ^{
        NSString *testPath = @"/api/v1/courses/1/quizzes";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKQuiz fetchQuizzesForCourse:course success:nil failure:nil];
        });
    });
});


SPEC_END