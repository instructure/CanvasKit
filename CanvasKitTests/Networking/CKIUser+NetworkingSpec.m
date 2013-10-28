//
//  CKIUser+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKICourse.h"
#import "CKIUser+Networking.h"

SPEC_BEGIN(CKIUser_NetworkingSpec)

[CKIClient useTestClient];

describe(@"A CKIUser", ^{
    CKICourse *course = [CKICourse mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching all users for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/users";
        
        it(@"should call the CKIClient helper method with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIUser fetchUsersForCourse:course success:nil failure:nil];
        });
    });
    context(@"when searching for users in a course", ^{
        NSString *testPath = @"/api/v1/courses/123/search_users";
        
        it(@"should call the CKIClient helper method with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIUser fetchUsersMatchingSearchTerm:@"sheldon" course:course success:nil failure:nil];
        });
    });
});

SPEC_END
