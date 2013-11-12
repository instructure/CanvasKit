//
//  CKIClient+CKIFile.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIFile.h"
#import "CKIFile.h"

@implementation CKIClient (CKIFile)

- (void)fetchFile:(NSString *)fileID success:(void(^)(CKIFile *file))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIFile class] context:nil success:(void(^)(CKIModel *file))success failure:failure];
}

@end
