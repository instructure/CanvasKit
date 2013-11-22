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

- (RACSignal *)fetchUsersForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"users"];
    NSDictionary *parameters = @{@"include": @[@"avatar_url"]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:course];
}

- (RACSignal *)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:course];
}

@end
