//
//  CKService+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKService+Networking.h"
#import "CKService.h"

SPEC_BEGIN(CKService_NetworkingSpec)

[CKClient useTestClient];

describe(@"A CKService", ^{
    
    context(@"when fetching a service", ^{
        NSString *testPath = @"/api/v1/services/kaltura";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKService fetchServiceSuccess:nil failure:nil];
        });
    });
});


SPEC_END