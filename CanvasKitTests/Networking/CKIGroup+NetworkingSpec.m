//
//  CKIGroup+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKIGroup+Networking.h"
#import "CKICourse.h"

SPEC_BEGIN(CKIGroup_NetworkingSpec)

[CKIClient useTestClient];

describe(@"A CKIGroup", ^{
    context(@"when fetching a group", ^{
        NSString *testPath = @"/api/v1/groups/1";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper with correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIGroup fetchGroup:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching the current user's groups", ^{
        NSString *testPath = @"/api/v1/self/groups";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKIGroup fetchGroupsForLocalUserWithSuccess:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/accounts/1/groups";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKIGroup fetchGroupsForAccount:@"1" success:nil failure:nil];
        });
    });
    
    context(@"when fetching groups for an account", ^{
        NSString *testPath = @"/api/v1/courses/123/groups";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        id course = [CKICourse mock];
        [course stub:@selector(id) andReturn:@"123"];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath,any(),any(),any(),any(),any()];
            [CKIGroup fetchGroupsForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END