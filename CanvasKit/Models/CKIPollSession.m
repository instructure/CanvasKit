//
//  CKIPollSession.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIPollSession.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIPollSession

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"isPublished": @"is_published",
                               @"hasPublicResults": @"has_public_results",
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id stringID) {
        return stringID;
    }];
}

- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"poll_sessions"] stringByAppendingPathComponent:self.id];
}

@end
