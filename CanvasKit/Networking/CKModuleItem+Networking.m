//
//  CKModuleItem+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModuleItem+Networking.h"
#import "CKClient.h"
#import "CKModule.h"

@implementation CKModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKModule *)module success:(void (^)(CKModuleItem *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    path = [path stringByAppendingPathComponent:moduleItemID];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKModuleItem class] context:module success:(void (^)(CKModel *))success failure:failure];
}

+ (void)fetchModuleItemsForModule:(CKModule *)module success:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKModuleItem class] context:module success:success failure:failure];
}

@end
