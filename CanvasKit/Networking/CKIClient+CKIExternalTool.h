//
//  CKIClient+CKIExternalTool.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class CKIExternalTool;

@interface CKIClient (CKIExternalTool)

/**
 Fetches all of the external tools for a course
 */
- (void) fetchExternalToolsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 Get a sessionless launch url for an external tool with id.
 */
- (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure;


/**
 Get a single external tool
 */
- (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure;

@end
