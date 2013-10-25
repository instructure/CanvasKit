//
//  CK2Group+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Group+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2Group (Networking)

+ (void)fetchGroup:(NSString *)groupID success:(void (^)(CK2Group *group))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"groups"];
    path = [path stringByAppendingPathComponent:groupID];
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Group class] context:nil success:(void (^)(CK2Model *group))success failure:failure];
}

+ (void)fetchGroupsForLocalUserWithSuccess:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"self/groups"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Group class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForAccount:(NSString *)accountID success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"accounts"];
    path = [path stringByAppendingPathComponent:accountID];
    path = [path stringByAppendingPathComponent:@"groups"];
    // TODO when we add Accounts, we should really set the context here.
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Group class] context:nil success:success failure:failure];
}

+ (void)fetchGroupsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"courses"];
    path = [path stringByAppendingPathComponent:course.id];
    path = [path stringByAppendingPathComponent:@"groups"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Group class] context:course success:success failure:failure];
}

@end
