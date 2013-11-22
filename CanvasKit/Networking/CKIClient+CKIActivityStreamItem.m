//
//  CKIClient+CKIActivityStreamItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIActivityStreamItem.h"
#import "CKIActivityStreamItem.h"

@implementation CKIClient (CKIActivityStreamItem)

- (RACSignal *)fetchActivityStream
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/activity_stream"];
    NSValueTransformer *transformer = [CKIActivityStreamItem activityStreamItemTransformer];
    return [self fetchResponseAtPath:path parameters:nil transformer:transformer context:nil];
}

@end
