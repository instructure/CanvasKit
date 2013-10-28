//
//  CKIService+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKIService+Networking.h"
#import "CKIService.h"

SPEC_BEGIN(CKIService_NetworkingSpec)

[CKIClient useTestClient];

describe(@"A CKIService", ^{
    
    context(@"when fetching a service", ^{
        NSString *testPath = @"/api/v1/services/kaltura";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIService fetchServiceSuccess:nil failure:nil];
        });
    });
});


SPEC_END