//
//  CKIClient+CKIActivityStreamItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIActivityStreamItem.h"
#import "CKIActivityStreamItem.h"

@implementation CKIClient (CKIActivityStreamItem)

- (void)fetchActivityStreamWithSuccess:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/activity_stream"];
    
    NSValueTransformer *valueTransformer = [CKIActivityStreamItem activityStreamItemTransformer];
    [self fetchPagedResponseAtPath:path parameters:nil valueTransformer:valueTransformer context:nil success:success failure:failure];
}

@end
