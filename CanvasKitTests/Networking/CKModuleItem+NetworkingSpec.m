//
//  CKModuleItem+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKModule.h"
#import "CKModuleItem+Networking.h"

SPEC_BEGIN(CKModuleItem_NetworkingSpec)

describe(@"A CKModuleItem", ^{
    CKModule *module = [CKModule mock];
    [module stub:@selector(id) andReturn:@"456"];
    [module stub:@selector(path) andReturn:@"/api/v1/courses/123/modules/456"];
    
    context(@"when fetching a single module item", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items/789";
        [[CKClient sharedClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any()];
            [CKModuleItem fetchModuleItem:@"789" forModule:module success:nil failure:nil];
        });
    });
    
    context(@"when fetching a page of module items", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items";
        [[CKClient sharedClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKlClient helper with the correct path", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKModuleItem fetchModuleItemsForModule:module success:nil failure:nil];
        });
    });
});

SPEC_END