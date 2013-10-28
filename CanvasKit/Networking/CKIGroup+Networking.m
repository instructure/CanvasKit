//
//  CKIGroup+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIGroup+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIGroup (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CKIGroup *group))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"groups"];
    path = [path stringByAppendingPathComponent:groupID];
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil success:(void (^)(CKIModel *group))success failure:failure];
}

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"self/groups"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"accounts"];
    path = [path stringByAppendingPathComponent:accountID];
    path = [path stringByAppendingPathComponent:@"groups"];
    // TODO when we add Accounts, we should really set the context here.
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    path = [path stringByAppendingPathComponent:course.id];
    path = [path stringByAppendingPathComponent:@"groups"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIGroup class] context:course success:success failure:failure];
}

@end
