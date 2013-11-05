//
//  CKIPagedResponse.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKIContext.h"

/**
 Many of the JSON APIs in Canvas are paginated. This class is
 designed to abstract away the complexities of pagination.
 */
@interface CKIPagedResponse : NSObject

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
 Create a CKIPagedResponse.
 
 @param response the HTTP response.
 @param responseObject the parsed JSON array
 @param valueTransformer the transformer for individual elements of the JSON array
 @param context the context of all the items
 */
+ (instancetype)pagedResponseForTask:(NSURLSessionDataTask *)task responseObject:(NSArray *)responseObject valueTransformer:(NSValueTransformer *)valueTransformer context:(id<CKIContext>)context;

/**
 Fetch the page after this page
 
 @param success the success block which will accept the CKIPagedResponse result
 @param failure the block to be executed if the API call fails.
 */
- (void)fetchNextPageWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
