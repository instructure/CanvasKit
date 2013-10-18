//
//  CK2ClientSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/2/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "CK2Client+TestingClient.h"
#import "CK2Model.h"

SPEC_BEGIN(CK2ClientSpec)

describe(@"The CK2Client", ^{
    context(@"when fetching a single model", ^{
        NSString *testPath = @"api/v1/models";
        [CK2Client useTestClient];
        CK2Client *client = [CK2Client sharedClient];
        CK2Model *contxt = [CK2Model modelFromJSONDictionary:@{@"id":@1}];
        
        context(@"and there is an error", ^{
            [client returnErrorForPath:testPath];
            __block BOOL ranFailureBlock = NO;
            __block BOOL ranSuccessBlock = NO;
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
                ranSuccessBlock = YES;
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
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
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
            __block CK2Model *fetchedModel;
            [client fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
                fetchedModel = model;
            } failure:nil];
            
            it(@"should return model of the correct class", ^{
                [[fetchedModel should] beKindOfClass:[CK2Model class]];
            });
            it(@"should set the context", ^{
                [[contxt should] equal:fetchedModel.context];
            });
        });
    });
});

SPEC_END