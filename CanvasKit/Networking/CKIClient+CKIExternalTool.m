//
//  CKIClient+CKIExternalTool.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIExternalTool.h"
#import "CKIExternalTool.h"
#import "CKICourse.h"

@implementation CKIClient (CKIExternalTool)

- (void)fetchExternalToolsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIExternalTool class] context:course success:success failure:failure];
}

- (void)fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools/sessionless_launch"];
    
    NSDictionary *params = @{@"url":url};
    
    [self fetchModelAtPath:path parameters:params modelClass:[CKIExternalTool class] context:course success:(void (^)(CKIModel *))success failure:failure];
}

- (void)fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    path = [path stringByAppendingPathComponent:externalToolID];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIExternalTool class] context:course success:(void (^)(CKIModel *))success failure:failure];
}


@end
