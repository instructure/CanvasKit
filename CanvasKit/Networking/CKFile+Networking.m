//
//  CKFile+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFile+Networking.h"
#import "CKClient.h"

@implementation CKFile (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CKFile *file))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKFile class] context:nil success:(void(^)(CKModel *file))success failure:failure];
}

@end
