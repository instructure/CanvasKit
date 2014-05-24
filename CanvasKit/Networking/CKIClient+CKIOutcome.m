//
//  CKIClient+CKIOutcome.m
//  CanvasKit
//
//  Created by Brandon Pluim on 5/20/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKIOutcome.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CKIOutcome.h"

@implementation CKIClient (CKIOutcome)

- (RACSignal *)fetchOutcome:(CKIOutcome *)outcome
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:[NSString stringWithFormat:@"outcomes/%@", outcome.id]];
    return [self fetchResponseAtPath:outcome.path parameters:nil modelClass:[CKIOutcome class] context:CKIRootContext];
}

@end
