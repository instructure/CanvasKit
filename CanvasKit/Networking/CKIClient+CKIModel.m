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

- (void)refreshModel:(CKIModel *)model success:(void (^)())success failure:(void (^)(NSError *))failure
{
    [[self fetchResponseAtPath:model.path parameters:nil modelClass:[model class] context:model.context] subscribeNext:^(CKIModel *newModel) {
        [model mergeValuesForKeysFromModel:newModel];
    }];
}

@end
