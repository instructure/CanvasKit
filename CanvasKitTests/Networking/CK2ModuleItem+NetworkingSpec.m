//
//  CK2ModuleItem+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Module.h"
#import "CK2ModuleItem+Networking.h"

SPEC_BEGIN(CK2ModuleItem_NetworkingSpec)

describe(@"A CK2ModuleItem", ^{
    CK2Module *module = [CK2Module mock];
    [module stub:@selector(id) andReturn:@"456"];
    [module stub:@selector(path) andReturn:@"/api/v1/courses/123/modules/456"];
    
    context(@"when fetching a single module item", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items/789";
        [[CK2Client currentClient] returnResponseObject:@{} forPath:testPath];
        
        it(@"should call the CK2Client helper with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any()];
            [CK2ModuleItem fetchModuleItem:@"789" forModule:module success:nil failure:nil];
        });
    });
    
    context(@"when fetching a page of module items", ^{
        NSString *testPath = @"/api/v1/courses/123/modules/456/items";
        [[CK2Client currentClient] returnResponseObject:@[] forPath:testPath];
        
        it(@"should call the CK2lClient helper with the correct path", ^{
            [[[CK2Client currentClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2ModuleItem fetchModuleItemsForModule:module success:nil failure:nil];
        });
    });
});

SPEC_END