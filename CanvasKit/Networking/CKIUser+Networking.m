//
//  CKIUser+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIUser+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIUser (Networking)

+ (void)fetchUsersForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"users"];
    NSDictionary *parameters = @{@"include": @[@"avatar_url"]};
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:course success:success failure:failure];
}

+ (void)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CKICourse *)course success:(void(^)(CKIPagedResponse *))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CKIUser class] context:course success:success failure:failure];
}

@end
