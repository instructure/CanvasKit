//
//  CK2Module+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Module+Networking.h"
#import "CK2Course.h"

SPEC_BEGIN(CK2Module_NetworkingSpec)

describe(@"A CK2Module", ^{
    CK2Course *course = [CK2Course mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching a single module", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/1";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Module fetchModuleWithID:@"1" forCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching modules for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/modules";
        [[CK2Client sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2CLient helper method with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(),any()];
            [CK2Module fetchModulesForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END