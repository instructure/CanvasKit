//
//  CK2File+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2File+Networking.h"

SPEC_BEGIN(CK2File_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2File", ^{
    context(@"when fetching a single file", ^{
        NSString *testPath = @"/api/v1/files/123";
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2File fetchFile:@"123" success:nil failure:nil];
        });
    });
});

SPEC_END