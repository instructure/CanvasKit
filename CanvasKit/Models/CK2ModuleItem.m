//
//  CK2ModuleItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2ModuleItem.h"

#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

NSString * const CK2ModuleItemTypeFile = @"File";
NSString * const CK2ModuleItemTypePage = @"Page";
NSString * const CK2ModuleItemTypeDiscussion = @"Dicussion";
NSString * const CK2ModuleItemTypeAssignment = @"Assignment";
NSString * const CK2ModuleItemTypeQuiz = @"Quiz";
NSString * const CK2ModuleItemTypeSubHeader = @"SubHeader";
NSString * const CK2ModuleItemTypeExternalURL = @"ExternalUrl";
NSString * const CK2ModuleItemTypeExternalTool = @"ExternalTool";

NSString * const CK2ModuleItemCompletionRequirementMustView = @"must_view";
NSString * const CK2ModuleItemCompletionRequirementMustSubmit = @"must_submit";
NSString * const CK2ModuleItemCompletionRequirementMustContribute = @"must_contribute";
NSString * const CK2ModuleItemCompletionRequirementMinimumScore = @"min_score";

@interface CK2ModuleItem ()
// These properties store JSON data to be used
// to create the derived itemID property.
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *pageID;
@end

@implementation CK2ModuleItem

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
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
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
