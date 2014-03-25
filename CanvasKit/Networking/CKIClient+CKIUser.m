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

- (RACSignal *)fetchUsersForContext:(id<CKIContext>)context
{
    return [self fetchUsersWithParameters:nil context:context];
}

- (RACSignal *)fetchUsersWithParameters:(NSDictionary *)parameters context:(id<CKIContext>)context
{
    NSString *path = [context.path stringByAppendingPathComponent:@"users"];
    
    NSMutableDictionary *updatedParameters = [parameters mutableCopy];
    [updatedParameters setObject:@[@"avatar_url"] forKey:@"include"];
    
    return [self fetchResponseAtPath:path parameters:updatedParameters modelClass:[CKIUser class] context:context];
}

- (RACSignal *)fetchUsersMatchingSearchTerm:(NSString *)searchTerm context:(id<CKIContext>)context
{
    NSString *path = [context.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    return [self fetchResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:context];
}

@end
