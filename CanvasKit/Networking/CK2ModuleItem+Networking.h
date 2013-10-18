//
//  CK2ModuleItem+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2ModuleItem.h"

@class CK2Module;
@class CK2PagedResponse;

@interface CK2ModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CK2Module *)module success:(void (^)(CK2ModuleItem *))success failure:(void (^)(NSError *))failure;

+ (void)fetchModuleItemsForModule:(CK2Module *)module success:(void (^)(CK2PagedResponse *))success failure:(void (^)(NSError *))failure;

@end
