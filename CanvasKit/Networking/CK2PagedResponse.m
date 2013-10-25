//
//  CK2PagedResponse.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "CK2PagedResponse.h"
#import "NSHTTPURLResponse+Pagination.h"
#import "CK2Client.h"
#import "CK2Model.h"

@interface CK2PagedResponse ()

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
@property (nonatomic, strong) id<CK2Context> context;
@end

@implementation CK2PagedResponse

+ (instancetype)pagedResponseForTask:(NSURLSessionDataTask *)task responseObject:(NSArray *)responseObject modelClass:(Class)modelClass context:(id<CK2Context>)context
{
    NSAssert([modelClass isSubclassOfClass:[CK2Model class]], @"%@ is not a subclass of CK2Model", modelClass);
    CK2PagedResponse *pagedResponse = [[CK2PagedResponse alloc] init];
    
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
    
    [items enumerateObjectsUsingBlock:^(CK2Model *model, NSUInteger idx, BOOL *stop) {
        model.context = context;
    }];
    
    pagedResponse.items = items;
    
    
    return pagedResponse;
}

- (BOOL)isLastPage
{
    return self.currentPage == nil || [self.currentPage isEqual:self.lastPage];
}

- (void)fetchNextPageWithSuccess:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    [[CK2Client currentClient] GET:self.nextPage.relativeString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            CK2PagedResponse *pagedResponse = [CK2PagedResponse pagedResponseForTask:task responseObject:responseObject modelClass:self.modelClass context:self.context];
            success(pagedResponse);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
