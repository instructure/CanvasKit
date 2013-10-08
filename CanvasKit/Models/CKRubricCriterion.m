//
//  CKRubricCriterion.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKRubricCriterion.h"
#import "CKRubricCriterionRating.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKRubricCriterion

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *keyPaths = @{
        @"descriptionText": @"description",
        @"longDescription": @"long_description"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)ratingsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKRubricCriterionRating class]];
}

- (CKRubricCriterionRating *)selectedRating
{
    CKRubricCriterionRating *rating;
    
    NSUInteger index = [self.ratings indexOfObjectPassingTest:^BOOL(CKRubricCriterionRating *rating, NSUInteger idx, BOOL *stop) {
        return rating.points == self.points;
    }];
    
    if (index != NSNotFound) {
        rating = self.ratings[index];
    }
    
    return rating;
}

+ (NSValueTransformer *)idJSONTransformer
{
    return nil;
}

@end
