//
//  CKIClient+CKIFolder.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIFolder.h"
#import "CKICourse.h"
#import "CKIFolder.h"
#import "CKIFile.h"

@implementation CKIClient (CKIFolder)

- (RACSignal *)fetchFolder:(NSString *)folderID
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"folders"];
    path = [path stringByAppendingPathComponent:folderID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFolder class] context:nil];
}

- (RACSignal *)fetchRootFolderForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"folders/root"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFolder class] context:course];
}

- (RACSignal *)fetchFoldersForFolder:(CKIFolder *)folder
{
    NSString *path = folder.foldersURL.relativeString;
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFolder class] context:folder];
}

- (RACSignal *)fetchFilesForFolder:(CKIFolder *)folder
{
    NSString *path = folder.filesURL.relativeString;
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFile class] context:folder];
}

@end
