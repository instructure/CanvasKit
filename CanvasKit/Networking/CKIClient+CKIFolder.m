//
//  CKIClient+CKIFolder.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIFolder.h"
#import "CKICourse.h"
#import "CKIFolder.h"
#import "CKIFile.h"

@implementation CKIClient (CKIFolder)

- (void)fetchFolder:(NSString *)folderID success:(void (^)(CKIFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"folders"];
    path = [path stringByAppendingPathComponent:folderID];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIFolder class] context:nil success:(void (^)(CKIModel *))success failure:failure];
}

- (void)fetchRootFolderForCourse:(CKICourse *)course success:(void (^)(CKIFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"folders/root"];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIFolder class] context:nil success:(void (^)(CKIModel *))success failure:failure];
}

- (void)fetchFoldersForFolder:(CKIFolder *)folder success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = folder.foldersURL.relativeString;
    
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIFolder class] context:folder success:success failure:failure];
}

- (void)fetchFilesForFolder:(CKIFolder *)folder success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = folder.filesURL.relativeString;
    
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIFile class] context:folder success:success failure:failure];
}

@end
