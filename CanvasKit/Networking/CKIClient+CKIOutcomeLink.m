//
//  CKIClient+CKIOutcomeLink.m
//  CanvasKit
//
//  Created by Brandon Pluim on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKIOutcomeLink.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CKIOutcomeLink.h"
#import "CKIOutcome.h"
#import "CKIOutcomeGroup.h"

@implementation CKIClient (CKIOutcomeLink)

- (RACSignal *)fetchOutcomeLinksForOutcomeGroup:(CKIOutcomeGroup *)group
{
    NSString *path = [group.path stringByAppendingPathComponent:@"outcomes"];
    return [[self fetchResponseAtPath:path parameters:@{@"outcome_style": @"full"} modelClass:[CKIOutcomeLink class] context:group.context] map:^id(NSArray *outcomes) {
        
        [outcomes enumerateObjectsUsingBlock:^(CKIOutcomeLink *outcomeLink, NSUInteger idx, BOOL *stop) {
            outcomeLink.outcomeGroup = group;
        }];
        return outcomes;
    }];
}

@end
