//
//  CKUser+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKUser+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKUser (Networking)

+ (void)fetchUsersForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"users"];
    NSDictionary *parameters = @{@"include": @[@"avatar_url"]};
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CKUser class] context:course success:success failure:failure];
}

+ (void)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CKCourse *)course success:(void(^)(CKPagedResponse *))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CKUser class] context:course success:success failure:failure];
}

@end
