//
//  CKModuleItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModuleItem.h"

#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

NSString * const CKModuleItemTypeFile = @"File";
NSString * const CKModuleItemTypePage = @"Page";
NSString * const CKModuleItemTypeDiscussion = @"Dicussion";
NSString * const CKModuleItemTypeAssignment = @"Assignment";
NSString * const CKModuleItemTypeQuiz = @"Quiz";
NSString * const CKModuleItemTypeSubHeader = @"SubHeader";
NSString * const CKModuleItemTypeExternalURL = @"ExternalUrl";
NSString * const CKModuleItemTypeExternalTool = @"ExternalTool";

NSString * const CKModuleItemCompletionRequirementMustView = @"must_view";
NSString * const CKModuleItemCompletionRequirementMustSubmit = @"must_submit";
NSString * const CKModuleItemCompletionRequirementMustContribute = @"must_contribute";
NSString * const CKModuleItemCompletionRequirementMinimumScore = @"min_score";

@interface CKModuleItem ()
// These properties store JSON data to be used
// to create the derived itemID property.
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *pageID;
@end

@implementation CKModuleItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"contentID": @"content_id",
        @"pageID": @"page_url",
        @"htmlURL": @"html_url",
        @"apiURL": @"url",
        @"externalURL": @"external_url",
        @"completionRequirement": @"completion_requirement.type",
        @"minimumScore": @"completion_requirement.min_score",
        @"completed": @"completion_requirement.completed"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)contentIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)htmlURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)apiURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)externalURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (NSString *)itemID
{
    return self.contentID ?: self.pageID;
}

@end
