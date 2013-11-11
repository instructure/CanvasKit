//
//  CKILocalUser+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/5/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Helpers.h"
#import "CKILocalUser+Networking.h"
#import "CKIClient+TestingClient.h"
#import "CKIActivityStreamMessageItem.h"

SPEC_BEGIN(CKILocalUser_NetworkingSpec)

[CKIClient useTestClient];

describe(@"The current user", ^{
    context(@"when fetching the activity stream", ^{
        it(@"calls the correct API endpoint", ^{
            NSString *testPath = @"/api/v1/users/self/activity_stream";
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:valueTransformer:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [[CKILocalUser sharedUser] fetchActivityStreamWithSuccess:nil failure:nil];
        });
    });
});

SPEC_END