//
//  CKIModule+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKIModule+Networking.h"
#import "CKICourse.h"

SPEC_BEGIN(CKIModule_NetworkingSpec)

describe(@"A CKIModule", ^{
    CKICourse *course = [CKICourse mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching a single module", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/1";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper method with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIModule fetchModuleWithID:@"1" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching modules for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/modules";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKICLient helper method with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(),any()];
            [CKIModule fetchModulesForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END