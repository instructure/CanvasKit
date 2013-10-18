//
//  CKFolder+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CKClient+TestingClient.h"
#import "CKFolder+Networking.h"
#import "CKCourse.h"

SPEC_BEGIN(CKFolder_NetworkingSpec)

[CKClient useTestClient];

context(@"The CKFolder class", ^{
    describe(@"when fetching a single folder", ^{
        NSString *testPath = @"/api/v1/folders/123";
        
        it(@"should call the correct helper method", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKFolder fetchFolder:@"123" success:nil failure:nil];
        });
    });
    describe(@"when fetching the root folder for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/folders/root";
        CKCourse *course = [CKCourse mock];
        [course stub:@selector(path) andReturn:@"api/v1/courses/123"];
        
        it(@"should call the correct helper method", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CKFolder fetchRootFolderForCourse:course success:nil failure:nil];
        });
    });
});

context(@"A CKFolder instance", ^{
    CKFolder *folder = [CKFolder new];
    NSURL *fileURL = [NSURL URLWithString:@"http://blah.instructure.com/api/v1/folders/123/files"];
    NSURL *folderURL = [NSURL URLWithString:@"http://blah.instructure.com/api/v1/folders/123/folders"];
    [folder setValue:fileURL forKeyPath:@"fileURL"];
    [folder setValue:folderURL forKeyPath:@"folderURL"];
    
    describe(@"when fetching its folders", ^{
        NSString *testPath = folderURL.relativeString;
        
        it(@"should call the correct helper method", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [folder fetchFilesWithSuccess:nil failure:nil];
        });
    });
    
    describe(@"when fetching its files", ^{
        NSString *testPath = folderURL.relativeString;
        
        it(@"should call the correct helper method", ^{
            [[[CKClient sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
        });
        
        
    });
});

SPEC_END
