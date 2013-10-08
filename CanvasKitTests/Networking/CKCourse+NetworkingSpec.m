//
//  CKCourse+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKCourse+Networking.h"

SPEC_BEGIN(CKCourse_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKCourse", ^{
    context(@"when fetching courses for the a user", ^{
        NSString *testPath = @"/api/v1/courses";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKCourse fetchCoursesForCurrentUserWithSuccess:nil failure:nil];
        });
    });
});

SPEC_END