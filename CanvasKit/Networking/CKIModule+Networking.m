//
//  CKIModule+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModule+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIModule (Networking)

+ (void)fetchModulesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIModule class] context:course success:success failure:failure];
}

+ (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CKICourse *)course success:(void (^)(CKIModule *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    path = [path stringByAppendingPathComponent:moduleID];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:self context:course success:(void (^)(CKIModel *))success failure:failure];
}

@end
