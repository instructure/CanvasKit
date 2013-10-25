//
//  CK2ExternalTool+Networking.m
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2ExternalTool+Networking.h"
#import "CK2ExternalTool.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2ExternalTool (Networking)

+ (void) fetchExternalToolsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2ExternalTool class] context:course success:success failure:failure];
}

+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CK2Course *)course success:(void (^)(CK2ExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools/sessionless_launch"];
    
    NSDictionary *params = @{@"url":url};
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:params modelClass:[CK2ExternalTool class] context:course success:(void (^)(CK2Model *))success failure:failure];
}

+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CK2Course *)course success:(void (^)(CK2ExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    path = [path stringByAppendingPathComponent:externalToolID];
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2ExternalTool class] context:course success:(void (^)(CK2Model *))success failure:failure];
}

@end
