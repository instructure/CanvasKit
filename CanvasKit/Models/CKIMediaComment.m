//
//  CKIMediaComment.m
//  CanvasKit
//
//  Created by derrick on 11/26/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIMediaComment.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import <Mantle/Mantle.h>


@implementation CKIMediaComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"contentType": @"content_type",
                               @"mediaType": @"media_type",
                               @"displayName": @"display_name",
                               @"mediaID": @"media_id",
                               @"mediaType": @"media_type",
                               @"URL": @"url"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)mediaTypeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *mediaTypeString) {
        if ([mediaTypeString isEqualToString:@"audio"]) {
            return @(CKIMediaCommentTypeAudio);
        } else if ([mediaTypeString isEqualToString:@"video"]) {
            return @(CKIMediaCommentTypeVideo);
        }
        return @(CKIMediaCommentTypeNone);
    } reverseBlock:^(NSNumber *mediaCommentType) {
        switch ([mediaCommentType integerValue]) {
            case CKIMediaCommentTypeAudio:
                return @"audio";
            case CKIMediaCommentTypeVideo:
                return @"video";
            default:
                return (NSString *)nil;
        }
    }];
}

+ (NSValueTransformer *)URLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
