//
//  CK2ExternalTool+NetworkingSpec.m
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2ExternalTool+Networking.h"
#import "CK2Course.h"

SPEC_BEGIN(CK2ExternalTool_NetworkingSpec)

describe(@"A CK2ExternalTool", ^{
    CK2Course *course = [CK2Course mock];
    
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching all external tools for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools";
        [[CK2Client sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];

            [CK2ExternalTool fetchExternalToolsForCourse:course success:nil failure:nil];
        });
    
    });
    
    context(@"when fetching a sessionless launch url for an external tool with url", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools/sessionless_launch";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            
            [CK2ExternalTool fetchSessionlessLaunchURLWithURL:@"http://lti-tool-provider.herokuapp.com/lti_tool" andCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching a single external tool for a course with an external tool id", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools/24506";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];

            [CK2ExternalTool fetchExternalToolForCourseWithExternalToolID:@"24506" andCourse:course success:nil failure:nil];
        });
    });
    
});

SPEC_END