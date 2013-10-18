//
//  CK2AssignmentGroup.m
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2AssignmentGroup.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CK2Assignment.h"

@implementation CK2AssignmentGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"name": @"name"
                               ,@"position": @"position"
                               ,@"groupWeight": @"group_weight"
                               ,@"assignments": @"assignments"
                               ,@"rules": @"rules"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)assignmentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CK2Assignment class]];
}

@end
