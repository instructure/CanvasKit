//
//  CK2Folder+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Folder+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"
#import "CK2File.h"

@implementation CK2Folder (Networking)

+ (void)fetchFolder:(NSString *)folderID success:(void (^)(CK2Folder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"folders"];
    path = [path stringByAppendingPathComponent:folderID];
    
    [[CK2Client sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Folder class] context:nil success:(void (^)(CK2Model *))success failure:failure];
}

+ (void)fetchRootFolderForCourse:(CK2Course *)course success:(void (^)(CK2Folder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"folders/root"];
    
    [[CK2Client sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Folder class] context:nil success:(void (^)(CK2Model *))success failure:failure];
}

- (void)fetchFoldersWithSuccess:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.foldersURL.relativeString;
    
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Folder class] context:self success:success failure:failure];
}

- (void)fetchFilesWithSuccess:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.filesURL.relativeString;
    
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2File class] context:self success:success failure:failure];
}

@end
