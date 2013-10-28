//
//  CKICourse+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKICourse+Networking.h"

SPEC_BEGIN(CKICourse_NetworkingSpec)

[CKIClient useTestClient];

describe(@"A CKICourse", ^{
    context(@"when fetching courses for the a user", ^{
        NSString *testPath = @"/api/v1/courses";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKICourse fetchCoursesForCurrentUserWithSuccess:nil failure:nil];
        });
    });
});

SPEC_END