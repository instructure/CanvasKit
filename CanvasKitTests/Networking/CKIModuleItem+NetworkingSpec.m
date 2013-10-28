//
//  CKIModuleItem+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKIClient+TestingClient.h"
#import "CKIModule.h"
#import "CKIModuleItem+Networking.h"

SPEC_BEGIN(CKIModuleItem_NetworkingSpec)

describe(@"A CKIModuleItem", ^{
    CKIModule *module = [CKIModule mock];
    [module stub:@selector(id) andReturn:@"456"];
    [module stub:@selector(path) andReturn:@"/api/v1/courses/123/modules/456"];
    
    context(@"when fetching a single module item", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items/789";
        [[CKIClient currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CKIClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any()];
            [CKIModuleItem fetchModuleItem:@"789" forModule:module success:nil failure:nil];
        });
    });
    
    context(@"when fetching a page of module items", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items";
        [[CKIClient currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CKIlClient helper with the correct path", ^{
            [[[CKIClient currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKIModuleItem fetchModuleItemsForModule:module success:nil failure:nil];
        });
    });
});

SPEC_END