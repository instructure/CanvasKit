//
//  CKIService+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIService+Networking.h"

#import "CKIClient.h"

@implementation CKIService (Networking)

+ (void)fetchServiceSuccess:(void (^)(CKIService *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"services/kaltura"];
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIService class] context:CKIRootContext success:(void (^)(CKIModel *service))success failure:failure];
}

@end
