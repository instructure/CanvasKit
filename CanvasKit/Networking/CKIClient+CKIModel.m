//
//  CKIClient+CKIModel.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIModel.h"
#import "CKIModel.h"


@implementation CKIClient (CKIModel)

- (void)refreshModel:(CKIModel *)model success:(void (^)())success failure:(void (^)(NSError *))failure
{
    [self fetchModelAtPath:model.path parameters:nil modelClass:[model class] context:model.context success:^(CKIModel *refreshedModel) {
        [model mergeValuesForKeysFromModel:refreshedModel];
    } failure:failure];
}

@end
