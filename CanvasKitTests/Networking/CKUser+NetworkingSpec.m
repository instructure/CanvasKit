//
//  CKUser+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKCourse.h"
#import "CKUser+Networking.h"

SPEC_BEGIN(CKUser_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKUser", ^{
    CKCourse *course = [CKCourse mock];
    [course stub:@selector(id) andReturn:@"123"];
    [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
    
    context(@"when fetching all users for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/users";
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKUser fetchUsersForCourse:course success:nil failure:nil];
        });
    });
    context(@"when searching for users in a course", ^{
        NSString *testPath = @"/api/v1/courses/123/search_users";
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKUser fetchUsersMatchingSearchTerm:@"sheldon" course:course success:nil failure:nil];
        });
        it(@"should call the CKClient helper method with the search_term parameter", ^{
            NSDictionary *parameters = @{@"search_term": @"sheldon"};
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:any(), parameters, any(), any(), any(), any()];
            [CKUser fetchUsersMatchingSearchTerm:@"sheldon" course:course success:nil failure:nil];
        });
    });
});

SPEC_END
