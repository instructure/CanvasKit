//
//  CKIPagedResponse.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CKIPagedResponse.h"
#import "NSHTTPURLResponse+Pagination.h"
#import "CKIClient.h"
#import "CKIModel.h"

@interface CKIPagedResponse ()

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
@property (nonatomic, strong) id<CKIContext> context;
@end

@implementation CKIPagedResponse

+ (instancetype)pagedResponseForTask:(NSURLSessionDataTask *)task responseObject:(NSArray *)responseObject modelClass:(Class)modelClass context:(id<CKIContext>)context
{
    NSAssert([modelClass isSubclassOfClass:[CKIModel class]], @"%@ is not a subclass of CKIModel", modelClass);
    CKIPagedResponse *pagedResponse = [[CKIPagedResponse alloc] init];
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    pagedResponse.currentPage = response.currentPage;
    pagedResponse.nextPage = response.nextPage;
    pagedResponse.previousPage = response.previousPage;
    pagedResponse.firstPage = response.firstPage;
    pagedResponse.lastPage = response.lastPage;
    
    pagedResponse.modelClass = modelClass;
    
    pagedResponse.context = context;
    
    NSValueTransformer *arrayTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:modelClass];
    NSArray *items = [arrayTransformer transformedValue:responseObject];
    
    [items enumerateObjectsUsingBlock:^(CKIModel *model, NSUInteger idx, BOOL *stop) {
        model.context = context;
    }];
    
    pagedResponse.items = items;
    
    
    return pagedResponse;
}

- (BOOL)isLastPage
{
    return self.currentPage == nil || [self.currentPage isEqual:self.lastPage];
}

- (void)fetchNextPageWithSuccess:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    [[CKIClient currentClient] GET:self.nextPage.relativeString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CKIPagedResponse *pagedResponse = [CKIPagedResponse pagedResponseForTask:task responseObject:responseObject modelClass:self.modelClass context:self.context];
            success(pagedResponse);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
