//
//  CKIClient+CKIUser.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIUser.h"
#import "CKIUser.h"
#import "CKICourse.h"

@implementation CKIClient (CKIUser)

- (void)fetchUsersForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    [self fetchUsersWithParameters:nil course:course success:success failure:failure];
}

- (void)fetchUsersWithParameters:(NSDictionary *)parameters course:(CKICourse *)course success:(void(^)(CKIPagedResponse *))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"users"];

    NSMutableDictionary *updatedParameters = [parameters mutableCopy];
    [updatedParameters setObject:@[@"avatar_url"] forKey:@"include"];
    
    [self fetchPagedResponseAtPath:path parameters:updatedParameters modelClass:[CKIUser class] context:course success:success failure:failure];
}

- (void)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CKICourse *)course success:(void(^)(CKIPagedResponse *))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    
    [self fetchPagedResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:course success:success failure:failure];
}

@end
