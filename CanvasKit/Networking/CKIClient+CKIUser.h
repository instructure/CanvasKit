//
//  CKIClient+CKIUser.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;

@interface CKIClient (CKIUser)

/**
 Fetch all the users for the current course.
 
 @param course the course to fetch the users for
 */
- (RACSignal *)fetchUsersForCourse:(CKICourse *)course;

/**
 Fetch users for the current course filtered by parameters.
 
 @param parameters the parameters for fetching users in the course
 @param course the course to fetch the users for
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (RACSignal *)fetchUsersWithParameters:(NSDictionary *)parameters course:(CKICourse *)course;


/**
 Fetch all the users for the current course.
 
 @param searchTerm the search term for searching users in the course
 @param course the course to fetch the users for
 */
- (RACSignal *)fetchUsersMatchingSearchTerm:(NSString *)searchTerm course:(CKICourse *)course;

@end
