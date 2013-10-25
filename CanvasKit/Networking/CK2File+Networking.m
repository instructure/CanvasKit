//
//  CK2File+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2File+Networking.h"
#import "CK2Client.h"

@implementation CK2File (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CK2File *file))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"files"];
    path = [path stringByAppendingPathComponent:fileID];
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2File class] context:nil success:(void(^)(CK2Model *file))success failure:failure];
}

@end
