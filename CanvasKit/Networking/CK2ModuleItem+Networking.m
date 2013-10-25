//
//  CK2ModuleItem+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2ModuleItem+Networking.h"
#import "CK2Client.h"
#import "CK2Module.h"

@implementation CK2ModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CK2Module *)module success:(void (^)(CK2ModuleItem *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    path = [path stringByAppendingPathComponent:moduleItemID];
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2ModuleItem class] context:module success:(void (^)(CK2Model *))success failure:failure];
}

+ (void)fetchModuleItemsForModule:(CK2Module *)module success:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2ModuleItem class] context:module success:success failure:failure];
}

@end
