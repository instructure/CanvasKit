//
//  CK2APIV1.m
//  CanvasKit
//
//  Created by derrick on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2APIV1.h"

@implementation CK2APIV1
+ (instancetype)context {
    static CK2APIV1 *apiV1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiV1 = [CK2APIV1 new];
    });
    return apiV1;
}

- (NSString *)path
{
    return @"/api/v1";
}

- (void)setContext:(id<CK2Context>)context
{
    [self doesNotRecognizeSelector:_cmd];
}

- (id<CK2Context>)context {
    return nil;
}

@end
