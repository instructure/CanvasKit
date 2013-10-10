//
//  CKFile+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKFile+Networking.h"

SPEC_BEGIN(CKFile_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKFile", ^{
    context(@"when fetching a single file", ^{
        NSString *testPath = @"/api/v1/files/123";
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKFile fetchFile:@"123" success:nil failure:nil];
        });
    });
});

SPEC_END