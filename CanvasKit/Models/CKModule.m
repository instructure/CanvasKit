//
//  CKModule.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModule.h"
#import "CKModuleItem.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

NSString * const CKModuleStateLocked = @"locked";
NSString * const CKModuleStateUnlocked = @"unlocked";
NSString * const CKModuleStateStarted = @"started";
NSString * const CKModuleStateCompleted = @"completed";

NSString * const CKModuleWorkflowStateActive = @"active";
NSString * const CKModuleWorkflowStateDeleted = @"deleted";

@implementation CKModule

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
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)itemsAPIURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)completedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKModuleItem class]];
}

@end
