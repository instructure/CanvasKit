//
//  CK2LockInfo.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/28/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2LockInfo.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

@implementation CK2LockInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"assetString": @"asset_string",
        @"unlockAt": @"context_module.unlock_at",
        @"startAt": @"context_module.start_at",
        @"endAt": @"context_module.end_at",
        @"moduleID": @"context_module.id",
        @"moduleName": @"context_module.name",
        @"moduleCourseID": @"context_module.context_id"
    };
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)startAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)endAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)moduleIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

+ (NSValueTransformer *)moduleCourseIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

@end
