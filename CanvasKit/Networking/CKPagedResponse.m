//
//  CKPagedResponse.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CKPagedResponse.h"
#import "NSHTTPURLResponse+Pagination.h"
#import "CKClient.h"
#import "CKModel.h"

@interface CKPagedResponse ()

/**
 The current URL of this page of responses.
 */
@property (nonatomic, strong) NSURL *currentPage;


/**
 The next URL in the paginated series.
 */
@property (nonatomic, copy) NSURL *nextPage;

/**
 The URL or the previous page in the series.
 */
@property (nonatomic, copy) NSURL *previousPage;

/**
 The URL of the first page in the series.
 */
@property (nonatomic, copy) NSURL *firstPage;

/**
 The URL of the last page in the series.
 */
@property (nonatomic, copy) NSURL *lastPage;

/**
 The class that will be used to transform the items in the response.
 */
@property (nonatomic) Class modelClass;

/**
 The context of the items.
 */
@property (nonatomic, strong) id<CKContext> context;
@end

@implementation CKPagedResponse

+ (instancetype)pagedResponseForOperation:(AFHTTPRequestOperation *)operation responseObject:(NSArray *)responseObject modelClass:(Class)modelClass context:(id<CKContext>)context
{
    NSAssert([modelClass isSubclassOfClass:[CKModel class]], @"%@ is not a subclass of CKModel", modelClass);
    CKPagedResponse *pagedResponse = [[CKPagedResponse alloc] init];
    
    NSHTTPURLResponse *response = operation.response;
    pagedResponse.currentPage = response.currentPage;
    pagedResponse.nextPage = response.nextPage;
    pagedResponse.previousPage = response.previousPage;
    pagedResponse.firstPage = response.firstPage;
    pagedResponse.lastPage = response.lastPage;
    
    pagedResponse.modelClass = modelClass;
    
    pagedResponse.context = context;
    
    NSValueTransformer *arrayTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:modelClass];
    NSArray *items = [arrayTransformer transformedValue:responseObject];
    
    [items enumerateObjectsUsingBlock:^(CKModel *model, NSUInteger idx, BOOL *stop) {
        model.context = context;
    }];
    
    pagedResponse.items = items;
    
    
    return pagedResponse;
}

- (BOOL)isLastPage
{
    return self.currentPage == nil || [self.currentPage isEqual:self.lastPage];
}

- (void)fetchNextPageWithSuccess:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    [[CKClient sharedClient] GET:self.nextPage.relativeString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            CKPagedResponse *pagedResponse = [CKPagedResponse pagedResponseForOperation:operation responseObject:responseObject modelClass:self.modelClass context:self.context];
            success(pagedResponse);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
