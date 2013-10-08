//
//  CKLockInfo.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/28/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKLockInfo.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

@implementation CKLockInfo

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
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)startAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)endAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)moduleIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)moduleCourseIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

@end
