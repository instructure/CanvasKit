//
//  CKPagedResponseSpec.m
//  CanvasKit
//
//  Created by derrick on 10/10/13.
//  Copyright 2013 Instructure. All rights reserved.
//

#import "NSHTTPURLResponse+Pagination.h"
#import <Kiwi/Kiwi.h>
#import "CKPagedResponse.h"
#import "CKCourse.h"
#import "CKClient.h"
#import <AFNetworking/AFHTTPRequestOperation.h>

SPEC_BEGIN(CKPagedResponseSpec)

describe(@"CKPagedResponse", ^{
    id mockResponse = [NSHTTPURLResponse new];
    id mockOp = [KWMock mockForClass:[AFHTTPRequestOperation class]];

    [[mockOp stubAndReturn:mockResponse] response];
    NSArray *modelObjects = @[];
    
    NSURL *(^page)(NSInteger) = ^(NSInteger number) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://school.instructure.com/api/v1/courses?page=%@", @(number)]];
    };
    
//    context(@"when a response is one of many many pages", ^{
//        [[mockResponse should] receive:@selector(currentPage) andReturn:page(3)];
//        [[mockResponse should] receive:@selector(nextPage) andReturn:page(4)];
//        [[mockResponse should] receive:@selector(lastPage) andReturn:page(6)];
//        
//        CKPagedResponse *pagedResponse = [CKPagedResponse pagedResponseForOperation:mockOp responseObject:modelObjects modelClass:[CKCourse class] context:CKRootContext];
//        
//        it(@"should not be the last page", ^{
//            [[theValue(pagedResponse.isLastPage) should] equal:@(NO)];
//        });
//        
//        it(@"should fetch the next page", ^{
//            [[[CKClient sharedClient] should] receive:@selector(GET:parameters:success:failure:) withArguments:page(4).relativePath, any(), any(), any()];
//            
//            [pagedResponse fetchNextPageWithSuccess:nil failure:nil];
//        });
//    });
});

SPEC_END
