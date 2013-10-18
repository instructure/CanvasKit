//
//  CK2Folder+NetworkingSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CK2Client+TestingClient.h"
#import "CK2Folder+Networking.h"
#import "CK2Course.h"

SPEC_BEGIN(CK2Folder_NetworkingSpec)

[CK2Client useTestClient];

context(@"The CK2Folder class", ^{
    describe(@"when fetching a single folder", ^{
        NSString *testPath = @"/api/v1/folders/123";
        
        it(@"should call the correct helper method", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Folder fetchFolder:@"123" success:nil failure:nil];
        });
    });
    describe(@"when fetching the root folder for a course", ^{
        NSString *testPath = @"/api/v1/courses/123/folders/root";
        CK2Course *course = [CK2Course mock];
        [course stub:@selector(path) andReturn:@"/api/v1/courses/123"];
        
        it(@"should call the correct helper method", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchModelAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [CK2Folder fetchRootFolderForCourse:course success:nil failure:nil];
        });
    });
});

context(@"A CK2Folder instance", ^{
    CK2Folder *folder = [CK2Folder new];
    NSURL *fileURL = [NSURL URLWithString:@"http://blah.instructure.com/api/v1/folders/123/files"];
    NSURL *folderURL = [NSURL URLWithString:@"http://blah.instructure.com/api/v1/folders/123/folders"];
    folder.filesURL = fileURL;
    folder.foldersURL = folderURL;
    
    describe(@"when fetching its folders", ^{
        NSString *testPath = folderURL.relativeString;
        
        it(@"should call the correct helper method", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [folder fetchFoldersWithSuccess:nil failure:nil];
        });
    });
    
    describe(@"when fetching its files", ^{
        NSString *testPath = fileURL.relativeString;
        
        it(@"should call the correct helper method", ^{
            [[[CK2Client sharedClient] should] receive:@selector(fetchPagedResponseAtPath:parameters:modelClass:context:success:failure:) withArguments:testPath, any(), any(), any(), any(), any()];
            [folder fetchFilesWithSuccess:nil failure:nil];
        });
    });
});

SPEC_END
