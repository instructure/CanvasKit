//
//  CKIFolder+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIFolder+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"
#import "CKIFile.h"

@implementation CKIFolder (Networking)

+ (void)fetchFolder:(NSString *)folderID success:(void (^)(CKIFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"folders"];
    path = [path stringByAppendingPathComponent:folderID];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIFolder class] context:nil success:(void (^)(CKIModel *))success failure:failure];
}

+ (void)fetchRootFolderForCourse:(CKICourse *)course success:(void (^)(CKIFolder *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"folders/root"];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIFolder class] context:nil success:(void (^)(CKIModel *))success failure:failure];
}

- (void)fetchFoldersWithSuccess:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.foldersURL.relativeString;
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIFolder class] context:self success:success failure:failure];
}

- (void)fetchFilesWithSuccess:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = self.filesURL.relativeString;
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIFile class] context:self success:success failure:failure];
}

@end
