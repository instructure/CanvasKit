//
//  CKFolder+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFolder+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"
#import "CKFile.h"

@implementation CKFolder (Networking)

+ (void)fetchFolder:(NSString *)folderID success:(void (^)(CKFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"folders"];
    path = [path stringByAppendingPathComponent:folderID];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKFolder class] context:nil success:(void (^)(CKModel *))success failure:failure];
}

+ (void)fetchRootFolderForCourse:(CKCourse *)course success:(void (^)(CKFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingString:@"folders/root"];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKFolder class] context:nil success:(void (^)(CKModel *))success failure:failure];
}

- (void)fetchFoldersWithSuccess:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.foldersURL.relativeString;
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKFolder class] context:self success:success failure:failure];
}

- (void)fetchFilesWithSuccess:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.filesURL.relativeString;
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKFile class] context:self success:success failure:failure];
}

@end
