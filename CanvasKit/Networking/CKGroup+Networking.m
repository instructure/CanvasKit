//
//  CKGroup+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKGroup+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKGroup (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CKGroup *group))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"groups"];
    path = [path stringByAppendingPathComponent:groupID];
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKGroup class] context:nil success:(void (^)(CKModel *group))success failure:failure];
}

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"self/groups"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKGroup class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"accounts"];
    path = [path stringByAppendingPathComponent:accountID];
    path = [path stringByAppendingPathComponent:@"groups"];
    // TODO when we add Accounts, we should really set the context here.
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKGroup class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"courses"];
    path = [path stringByAppendingPathComponent:course.id];
    path = [path stringByAppendingPathComponent:@"groups"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKGroup class] context:course success:success failure:failure];
}

@end
