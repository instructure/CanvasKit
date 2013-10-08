//
//  CKAssignmentGroup.m
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKAssignmentGroup.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CKAssignment.h"

@implementation CKAssignmentGroup

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
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKAssignment class]];
}

@end
