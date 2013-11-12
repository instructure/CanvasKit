//
//  CKIModel+Networking.m
//  CanvasKit
//
//  Created by derrick on 11/5/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel+Networking.h"
#import "CKIClient.h"

@implementation CKIModel (Networking)

- (void)refreshWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure
{
    [[CKIClient currentClient] fetchModelAtPath:self.path parameters:nil modelClass:[self class] context:self.context success:^(CKIModel *model) {
        [self mergeValuesForKeysFromModel:model];
    } failure:failure];
}

@end
