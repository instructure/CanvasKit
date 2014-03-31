//
//  CKIClient+CKIUser.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIUser.h"
#import "CKIUser.h"
#import "CKICourse.h"

@implementation CKIClient (CKIUser)

- (RACSignal *)fetchUsersForContext:(id <CKIContext>)context
{
    return [self fetchUsersWithParameters:@{@"include" : @[@"avatar_url", @"enrollments"]} context:context];
}

- (RACSignal *)fetchUsersWithParameters:(NSDictionary *)parameters context:(id <CKIContext>)context
{
    NSString *path = [context.path stringByAppendingPathComponent:@"users"];
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:context];
}

@end
