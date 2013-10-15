//
//  CKService+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKService+Networking.h"

#import "CKClient.h"

@implementation CKService (Networking)

+ (void)fetchServiceSuccess:(void (^)(CKService *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"services/kaltura"];
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKService class] context:CKRootContext success:(void (^)(CKModel *service))success failure:failure];
}

@end
