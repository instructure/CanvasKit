//
//  CKModule+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKModule+Networking.h"
#import "CKCourse.h"

SPEC_BEGIN(CKModule_NetworkingSpec)

describe(@"A CKModule", ^{
    CKCourse *course = [CKCourse mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching a single module", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/1";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKModule fetchModuleWithID:@"1" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching modules for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/modules";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKCLient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(),any()];
            [CKModule fetchModulesForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END