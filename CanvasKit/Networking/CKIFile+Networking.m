//
//  CKIFile+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIFile+Networking.h"
#import "CKIClient.h"

@implementation CKIFile (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CKIFile *file))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIFile class] context:nil success:(void(^)(CKIModel *file))success failure:failure];
}

@end
