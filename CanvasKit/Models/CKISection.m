//
//  CKISection.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/12/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKISection.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKISection


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"name": @"name",
                               @"courseID": @"course_id",
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"sections"] stringByAppendingPathComponent:self.id];
}

@end
