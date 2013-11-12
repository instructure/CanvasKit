//
//  CKIClient+CKIModule.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIModule.h"
#import "CKICourse.h"
#import "CKIModule.h"

@implementation CKIClient (CKIModule)

- (void)fetchModulesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIModule class] context:course success:success failure:failure];
}

- (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CKICourse *)course success:(void (^)(CKIModule *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    path = [path stringByAppendingPathComponent:moduleID];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIModule class] context:course success:(void (^)(CKIModel *))success failure:failure];
}

@end
