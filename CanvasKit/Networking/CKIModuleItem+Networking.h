//
//  CKIModuleItem+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModuleItem.h"

@class CKIModule;
@class CKIPagedResponse;

@interface CKIModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKIModule *)module success:(void (^)(CKIModuleItem *))success failure:(void (^)(NSError *))failure;

+ (void)fetchModuleItemsForModule:(CKIModule *)module success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure;

@end
