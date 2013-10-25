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
    beforeEach(^{
        [CK2Client useTestClient];
    });
    
    context(@"when the current client is not set", ^{
        beforeAll(^{
            [CK2Client setCurrentClient:nil];
        });
        
        it(@"should raise an exception when getting current client", ^{
            [[theBlock(^{
                [CK2Client currentClient];
            }) should] raise];
        });
    });
    
    context(@"when the current client is set", ^{
        __block CK2Client *client;
        beforeEach(^{
            NSURL *baseURL = [NSURL URLWithString:@"https://example.com/"];
            client = [CK2Client clientWithBaseURL:baseURL];
            [CK2Client setCurrentClient:client];
        });
        
        it(@"should return the current client", ^{
            [[[CK2Client currentClient] should] equal:client];
        });
    });
    
    context(@"when fetching a single model", ^{
        __block NSString *testPath;
        __block CK2Model *contxt;
        beforeEach(^{
            testPath = @"api/v1/models";
            contxt = [CK2Model modelFromJSONDictionary:@{@"id":@1}];
        });
        
        
        context(@"and there is an error", ^{
            __block BOOL ranFailureBlock = NO;
            __block BOOL ranSuccessBlock = NO;
            beforeEach(^{
                ranFailureBlock = NO;
                ranSuccessBlock = NO;
                [[CK2Client currentClient] returnErrorForPath:testPath];
                [[CK2Client currentClient] fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
                    ranSuccessBlock = YES;
                } failure:^(NSError *error) {
                    ranFailureBlock = YES;
                }];
            });
            
            it(@"should not run the success block", ^{
                [[theValue(ranSuccessBlock) shouldNot] beTrue];
            });
            it(@"should run the error block", ^{
                [[theValue(ranFailureBlock) should] beTrue];
            });
        });

        context(@"and there is no error", ^{
            __block BOOL ranSuccessBlock;
            __block BOOL ranFailureBlock;
            beforeEach(^{
                [[CK2Client currentClient] returnResponseObject:@{} forPath:testPath];
                ranSuccessBlock = NO;
                ranFailureBlock = NO;
                [[CK2Client currentClient] fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
                    ranSuccessBlock = YES;
                } failure:^(NSError *error) {
                    ranFailureBlock = YES;
                }];
            });
            
            
            it(@"should run the success block", ^{
                [[theValue(ranSuccessBlock) should] beTrue];
            });
            it(@"should not run the error block", ^{
                [[theValue(ranFailureBlock) shouldNot] beTrue];
            });
        });
        
        context(@"and recieves a model", ^{
            __block CK2Model *fetchedModel;
            beforeEach(^{
                [[CK2Client currentClient] returnResponseObject:@{} forPath:testPath];
                [[CK2Client currentClient] fetchModelAtPath:testPath parameters:nil modelClass:[CK2Model class] context:contxt success:^(CK2Model *model) {
                    fetchedModel = model;
                } failure:nil];
            });
            
            
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