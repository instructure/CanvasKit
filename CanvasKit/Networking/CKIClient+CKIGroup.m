//
//  CKIClient+CKIGroup.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIGroup.h"
#import "CKIGroup.h"
#import "CKICourse.h"

@implementation CKIClient (CKIGroup)

- (RACSignal *)fetchGroup:(NSString *)groupID
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"groups"];
    path = [path stringByAppendingPathComponent:groupID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil];
}

- (RACSignal *)fetchGroupsForLocalUser
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"self/groups"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil];
}

- (RACSignal *)fetchGroupsForAccount:(NSString *)accountID
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"accounts"];
    path = [path stringByAppendingPathComponent:accountID];
    path = [path stringByAppendingPathComponent:@"groups"];
    // TODO when we add Accounts, we should really set the context here.
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil];
}

- (RACSignal *)fetchGroupsForCourse:(CKICourse *)course
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    path = [path stringByAppendingPathComponent:course.id];
    path = [path stringByAppendingPathComponent:@"groups"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:course];
}

@end
