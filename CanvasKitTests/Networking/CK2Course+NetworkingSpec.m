//
//  CK2Course+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Course+Networking.h"

SPEC_BEGIN(CK2Course_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2Course", ^{
    context(@"when fetching courses for the a user", ^{
        NSString *testPath = @"/api/v1/courses";
        [[CK2Client currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Course fetchCoursesForCurrentUserWithSuccess:nil failure:nil];
        });
    });
});

SPEC_END