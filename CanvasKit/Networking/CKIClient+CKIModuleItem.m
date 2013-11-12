//
//  CKIClient+CKIModuleItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIModuleItem.h"
#import "CKIModuleItem.h"
#import "CKIModule.h"

@implementation CKIClient (CKIModuleItem)

- (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKIModule *)module success:(void (^)(CKIModuleItem *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    path = [path stringByAppendingPathComponent:moduleItemID];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module success:(void (^)(CKIModel *))success failure:failure];
}

- (void)fetchModuleItemsForModule:(CKIModule *)module success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module success:success failure:failure];
}

@end
