//
//  CKIModuleItem+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModuleItem+Networking.h"
#import "CKIClient.h"
#import "CKIModule.h"

@implementation CKIModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKIModule *)module success:(void (^)(CKIModuleItem *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    path = [path stringByAppendingPathComponent:moduleItemID];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module success:(void (^)(CKIModel *))success failure:failure];
}

+ (void)fetchModuleItemsForModule:(CKIModule *)module success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module success:success failure:failure];
}

@end
