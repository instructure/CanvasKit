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

- (RACSignal *)fetchFile:(NSString *)fileID
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIFile class] context:nil];
}

@end
