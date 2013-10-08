//
//  CKModuleItem+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/3/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModuleItem.h"

@class CKModule;
@class CKPagedResponse;

@interface CKModuleItem (Networking)

+ (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKModule *)module success:(void (^)(CKModuleItem *))success failure:(void (^)(NSError *))failure;

+ (void)fetchModuleItemsForModule:(CKModule *)module success:(void (^)(CKPagedResponse *))success failure:(void (^)(NSError *))failure;

@end
