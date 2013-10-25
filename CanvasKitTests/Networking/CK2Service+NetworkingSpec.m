//
//  CK2Service+NetworkingSpec.m
//  CanvasKit
//
//  Created by Miles Wright on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Service+Networking.h"
#import "CK2Service.h"

SPEC_BEGIN(CK2Service_NetworkingSpec)

[CK2Client useTestClient];

describe(@"A CK2Service", ^{
    
    context(@"when fetching a service", ^{
        NSString *testPath = @"/api/v1/services/kaltura";
        [[CK2Client currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Service fetchServiceSuccess:nil failure:nil];
        });
    });
});


SPEC_END