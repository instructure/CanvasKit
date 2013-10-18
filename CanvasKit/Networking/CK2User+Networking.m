//
//  CK2User+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2User+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2User (Networking)

+ (void)fetchUsersForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"users"];
    NSDictionary *parameters = @{@"include": @[@"avatar_url"]};
    
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CK2User class] context:course success:success failure:failure];
}

+ (void)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CK2Course *)course success:(void(^)(CK2PagedResponse *))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"search_users"];
    NSDictionary *parameters = @{@"search_term": searchTerm, @"include": @[@"avatar_url"]};
    
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:parameters modelClass:[CK2User class] context:course success:success failure:failure];
}

@end
