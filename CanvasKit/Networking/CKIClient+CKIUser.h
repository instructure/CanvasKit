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
 Fetch all the users for the current context.
 
 @param course the course to fetch the users for
 */
- (RACSignal *)fetchUsersForContext:(id<CKIContext>)context;

/**
 Fetch users for the current context filtered by parameters.
 
 @param parameters the parameters for fetching users in the course
 @param context the context (course, group, account, etc.) to fetch the users for
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */

- (RACSignal *)fetchUsersWithParameters:(NSDictionary *)parameters context:(id<CKIContext>)context;

/**
 Fetch all the users for the current context.
 
 @param searchTerm the search term for searching users in the course
 @param context the context (course, group, ccount) to fetch the users for
 */
- (RACSignal *)fetchUsersMatchingSearchTerm:(NSString *)searchTerm context:(id<CKIContext>)context;

@end
