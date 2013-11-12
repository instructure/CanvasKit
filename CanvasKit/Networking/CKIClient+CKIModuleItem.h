//
//  CKIClient+CKIModuleItem.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIModule;
@class CKIModuleItem;

@interface CKIClient (CKIModuleItem)

- (void)fetchModuleItem:(NSString *)moduleItemID forModule:(CKIModule *)module success:(void (^)(CKIModuleItem *))success failure:(void (^)(NSError *))failure;

- (void)fetchModuleItemsForModule:(CKIModule *)module success:(void (^)(CKIPagedResponse *))success failure:(void (^)(NSError *))failure;

@end
