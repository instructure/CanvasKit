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
    context(@"when fetching all users for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/users";
        CKCourse *course = [CKCourse mock];
        [course stub:@selector(id) andReturn:@"123"];
        [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
        
        it(@"should call the CKClient helper method with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKUser fetchUsersForCourse:course success:nil failure:nil];
        });
    });
});

SPEC_END
