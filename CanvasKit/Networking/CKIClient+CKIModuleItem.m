//
//  CKIClient+CKIModuleItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIModuleItem.h"
#import "CKIModuleItem.h"
#import "CKIModule.h"

@implementation CKIClient (CKIModuleItem)

- (RACSignal *)fetchModuleItem:(NSString *)moduleItemID forModule:(CKIModule *)module
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    path = [path stringByAppendingPathComponent:moduleItemID];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module];
}

- (RACSignal *)fetchModuleItemsForModule:(CKIModule *)module
{
    NSString *path = [module.path stringByAppendingPathComponent:@"items"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIModuleItem class] context:module];
}

@end
