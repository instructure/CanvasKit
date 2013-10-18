//
//  CK2ExternalTool+Networking.h
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2ExternalTool.h"

@class CK2PagedResponse;
@class CK2Course;

@interface CK2ExternalTool (Networking)

/**
 Fetches all of the external tools for a course
 */
+ (void) fetchExternalToolsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure;

/**
  Get a sessionless launch url for an external tool with id.
 */
+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CK2Course *)course success:(void (^)(CK2ExternalTool *response))success failure:(void (^)(NSError *error))failure;


/**
 Get a single external tool
 */
+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CK2Course *)course success:(void (^)(CK2ExternalTool *response))success failure:(void (^)(NSError *error))failure;


@end