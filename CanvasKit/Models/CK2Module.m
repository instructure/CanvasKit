//
//  CK2Module.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Module.h"
#import "CK2ModuleItem.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

NSString * const CK2ModuleStateLocked = @"locked";
NSString * const CK2ModuleStateUnlocked = @"unlocked";
NSString * const CK2ModuleStateStarted = @"started";
NSString * const CK2ModuleStateCompleted = @"completed";

NSString * const CK2ModuleWorkflowStateActive = @"active";
NSString * const CK2ModuleWorkflowStateDeleted = @"deleted";

@implementation CK2Module

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"workflowState": @"workflow_state",
        @"unlockAt": @"unlock_at",
        @"requireSequentialProgress": @"require_sequential_progress",
        @"itemsCount": @"items_count",
        @"itemsAPIURL": @"items_url",
        @"completedAt": @"completed_at"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)itemsAPIURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)completedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CK2ModuleItem class]];
}

@end
