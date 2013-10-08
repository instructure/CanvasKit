//
//  CKClientSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/2/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "CKClient+TestingClient.h"
#import "CKModel.h"

SPEC_BEGIN(CKClientSpec)

describe(@"The CKClient", ^{
    context(@"when fetching a single model", ^{
        NSString *testPath = @"api/v1/models";
        [CKClient useTestClient];
        CKClient *client = [CKClient sharedClient];
        CKModel *contxt = [CKModel modelFromJSONDictionary:@{@"id":@1}];
        
        context(@"and there is an error", ^{
            [client returnErrorForPath:testPath];
            __block BOOL ranFailureBlock = NO;
            __block BOOL ranSuccessBlock = NO;
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CKModel class] context:contxt success:^(CKModel *model) {
                ranFailureBlock = YES;
            } failure:^(NSError *error) {
                ranFailureBlock = YES;
            }];
            
            it(@"should not run the success block", ^{
                [[theValue(ranSuccessBlock) shouldNot] beTrue];
            });
            it(@"should run the error block", ^{
                [[theValue(ranFailureBlock) should] beTrue];
            });
        });

        context(@"and there is no error", ^{
            [client returnResponseObject:@{} forPath:testPath];
            __block BOOL ranSuccessBlock = NO;
            __block BOOL ranFailureBlock = NO;
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CKModel class] context:contxt success:^(CKModel *model) {
                ranSuccessBlock = YES;
            } failure:^(NSError *error) {
                ranFailureBlock = YES;
            }];
            
            it(@"should run the success block", ^{
                [[theValue(ranSuccessBlock) should] beTrue];
            });
            it(@"should not run the error block", ^{
                [[theValue(ranFailureBlock) shouldNot] beTrue];
            });
        });
        
        context(@"and recieves a model", ^{
            [client returnResponseObject:@{} forPath:testPath];
            __block CKModel *fetchedModel;
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CKModel class] context:contxt success:^(CKModel *model) {
                fetchedModel = model;
            } failure:nil];
            
            it(@"should return model of the correct class", ^{
                [[fetchedModel should] beKindOfClass:[CKModel class]];
            });
            it(@"should set the context", ^{
                [[contxt should] equal:fetchedModel.context];
            });
        });
    });
});

SPEC_END