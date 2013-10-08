//
//  CKAPIV1.m
//  CanvasKit
//
//  Created by derrick on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKAPIV1.h"

@implementation CKAPIV1
+ (instancetype)context {
    static CKAPIV1 *apiV1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiV1 = [CKAPIV1 new];
    });
    return apiV1;
}

- (NSString *)path
{
    return @"/api/v1";
}

- (void)setContext:(id<CKContext>)context
{
    [self doesNotRecognizeSelector:_cmd];
}

- (id<CKContext>)context {
    return nil;
}

@end
