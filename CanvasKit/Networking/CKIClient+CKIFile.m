//
//  CKIClient+CKIFile.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CKIClient+CKIFile.h"
#import "CKIFile.h"

@implementation CKIClient (CKIFile)

- (RACSignal *)fetchFile:(NSString *)fileID
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFile class] context:nil];
}

- (RACSignal *)deleteFile:(CKIFile *)file
{
    NSString *path = [[CKIRootContext.path stringByAppendingPathComponent:@"files"] stringByAppendingPathComponent:file.id];
    return [self deleteObjectAtPath:path modelClass:[CKIFile class] parameters:0 context:nil];
}

@end
