//
//  CK2Group+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Group+Networking.h"
#import "CK2Course.h"

SPEC_BEGIN(CK2Group_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2Group", ^{
    context(@"when fetching a group", ^{
        NSString *testPath = @"/api/v1/groups/1";
        [[CK2Client sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper with correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Group fetchGroup:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching the current user's groups", ^{
        NSString *testPath = @"/api/v1/self/groups";
        [[CK2Client sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CK2Group fetchGroupsForLocalUserWithSuccess:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/accounts/1/groups";
        [[CK2Client sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CK2Group fetchGroupsForAccount:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/courses/123/groups";
        [[CK2Client sharedClient] returnResponseObject:@[] forPath:testPath];
        id course = [CK2Course mock];
        [course stub:@selector(id) andReturn:@"123"];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CK2Group fetchGroupsForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END