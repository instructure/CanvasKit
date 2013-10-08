//
//  CKModule+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModule+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKModule (Networking)

+ (void)fetchModulesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKModule class] context:course success:success failure:failure];
}

+ (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CKCourse *)course success:(void (^)(CKModule *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    path = [path stringByAppendingPathComponent:moduleID];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:self context:course success:(void (^)(CKModel *))success failure:failure];
}

@end
