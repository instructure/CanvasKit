//
//  CKGroup+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKGroup+Networking.h"
#import "CKCourse.h"

SPEC_BEGIN(CKGroup_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKGroup", ^{
    context(@"when fetching a group", ^{
        NSString *testPath = @"/api/v1/groups/1";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper with correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKGroup fetchGroup:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching the current user's groups", ^{
        NSString *testPath = @"/api/v1/self/groups";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKGroup fetchGroupsForLocalUserWithSuccess:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/accounts/1/groups";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKGroup fetchGroupsForAccount:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/courses/123/groups";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        id course = [CKCourse mock];
        [course stub:@selector(id) andReturn:@"123"];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKGroup fetchGroupsForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END