//
//  CKIModuleItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModuleItem.h"

#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

NSString * const CKIModuleItemTypeFile = @"File";
NSString * const CKIModuleItemTypePage = @"Page";
NSString * const CKIModuleItemTypeDiscussion = @"Dicussion";
NSString * const CKIModuleItemTypeAssignment = @"Assignment";
NSString * const CKIModuleItemTypeQuiz = @"Quiz";
NSString * const CKIModuleItemTypeSubHeader = @"SubHeader";
NSString * const CKIModuleItemTypeExternalURL = @"ExternalUrl";
NSString * const CKIModuleItemTypeExternalTool = @"ExternalTool";

NSString * const CKIModuleItemCompletionRequirementMustView = @"must_view";
NSString * const CKIModuleItemCompletionRequirementMustSubmit = @"must_submit";
NSString * const CKIModuleItemCompletionRequirementMustContribute = @"must_contribute";
NSString * const CKIModuleItemCompletionRequirementMinimumScore = @"min_score";

@interface CKIModuleItem ()
// These properties store JSON data to be used
// to create the derived itemID property.
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *pageID;
@end

@implementation CKIModuleItem

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
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
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
