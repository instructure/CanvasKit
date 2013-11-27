//
//  CKIClient+CKIModel.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIModel.h"
#import "CKIModel.h"

@implementation CKIClient (CKIModel)

- (RACSignal *)refreshModel:(CKIModel *)model parameters:(NSDictionary *)parameters
{
    return [[self fetchResponseAtPath:model.path parameters:parameters modelClass:[model class] context:model.context] map:^(CKIModel *updatedObject) {
        [model mergeValuesForKeysFromModel:updatedObject];
        return model;
    }];
}

@end
