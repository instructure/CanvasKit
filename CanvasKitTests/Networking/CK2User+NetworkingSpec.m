//
//  CK2User+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Course.h"
#import "CK2User+Networking.h"

SPEC_BEGIN(CK2User_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2User", ^{
    CK2Course *course = [CK2Course mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching all users for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/users";
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2User fetchUsersForCourse:course success:nil failure:nil];
        });
    });
    context(@"when searching for users in a course", ^{
        NSString *testPath = @"/api/v1/courses/123/search_users";
        
        it(@"should call the CK2Client helper method with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2User fetchUsersMatchingSearchTerm:@"sheldon" course:course success:nil failure:nil];
        });
    });
});

SPEC_END
