//
//  CK2Module+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Module.h"

@class CK2Course;
@class CK2PagedResponse;

@interface CK2Module (Networking)

/**
 Fetch all the modules for a given course.
 
 @param course the course that the modules are in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
+ (void)fetchModulesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

/**
 Fetch a specific module for a course.
 
 @param course the course that the module is in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
+ (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CK2Course *)course success:(void (^)(CK2Module *module))success failure:(void (^)(NSError *error))failure;

@end
