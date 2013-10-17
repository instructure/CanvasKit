//
//  CKExternalTool+NetworkingSpec.m
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKExternalTool+Networking.h"
#import "CKCourse.h"

SPEC_BEGIN(CKExternalTool_NetworkingSpec)

describe(@"A CKExternalTool", ^{
    CKCourse *course = [CKCourse mock];
    
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching all external tools for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];

            [CKExternalTool fetchExternalToolsForCourse:course success:nil failure:nil];
        });
    
    });
    
    context(@"when fetching a sessionless launch url for an external tool with url", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools/sessionless_launch";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            
            [CKExternalTool fetchSessionlessLaunchURLWithURL:@"http://lti-tool-provider.herokuapp.com/lti_tool" andCourse:course success:nil failure:nil];
        });
    });
    
    context(@"when fetching a single external tool for a course with an external tool id", ^{
        NSString *testPath = @"/api/v1/courses/123/external_tools/24506";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];

            [CKExternalTool fetchExternalToolForCourseWithExternalToolID:@"24506" andCourse:course success:nil failure:nil];
        });
    });
    
});

SPEC_END