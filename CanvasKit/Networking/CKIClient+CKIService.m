//
//  CKIClient+CKIService.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIService.h"
#include "CKIService.h"

@implementation CKIClient (CKIService)

- (void)fetchServiceSuccess:(void (^)(CKIService *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"services/kaltura"];
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIService class] context:CKIRootContext success:(void (^)(CKIModel *service))success failure:failure];
}


@end
