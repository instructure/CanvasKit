//
//  CKITodoItem.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITodoItem.h"
#import "CKIAssignment.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKITodoItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"type": @"type",
                               @"ignore": @"ignore",
                               @"ignorePermanently": @"ignore_permanently",
                               @"htmlUrl": @"html_url",
                               @"needsGradingCount": @"needs_grading_count",
                               @"contextType": @"context_type",
                               @"courseID": @"course_id",
                               @"groupID": @"group_id"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)ignoreJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)ignorePermanentlyJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)assignmentJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CKIAssignment class]];
}

@end
