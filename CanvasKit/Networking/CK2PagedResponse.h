//
//  CK2PagedResponse.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CK2Context.h"

@class AFHTTPRequestOperation;

/**
 Many of the JSON APIs in Canvas are paginated. This class is
 designed to abstract away the complexities of pagination.
 */
@interface CK2PagedResponse : NSObject

/**
 This is the last page in the paginated API.
 */
@property (nonatomic, readonly) BOOL isLastPage;

/**
 The models returned in the page response as determined by
 the supplied model class.
 */
@property (nonatomic, copy) NSArray *items;

/**
 Create a CK2PagedResponse.
 
 @param response the HTTP response.
 @param responseObject the parsed JSON array
 @param modelClass the class of models contained in the array.
 */
+ (instancetype)pagedResponseForOperation:(AFHTTPRequestOperation *)operation responseObject:(NSArray *)responseObject modelClass:(Class)modelClass context:(id<CK2Context>)context;

/**
 Fetch the page after this page
 
 @param success the success block which will accept the CK2PagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchNextPageWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
