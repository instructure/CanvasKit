//
//  CK2Page.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Page.h"
#import "CK2User.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

@interface CK2Page()
// these are private properties used to store the JSON values
// and used to create the derived lastEditedBy property.
@property (nonatomic, copy) NSString *lastEditedByID;
@property (nonatomic, copy) NSString *lastEditedByDisplayName;
@property (nonatomic, strong) NSURL *lastEditedByAvatarURL;
@end

@implementation CK2Page

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"id": @"url",
        @"createdAt": @"created_at",
        @"updatedAt": @"updated_at",
        @"hideFromStudents": @"hide_from_students",
        @"lastEditedByID": @"last_edited_by.id",
        @"lastEditedByDisplayName": @"last_edited_by.display_name",
        @"lastEditedByAvatarURL": @"last_edited_by.avatar_image_url"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return nil;
}

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)lastEditedByIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

+ (NSValueTransformer *)lastEditedByAvatarURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (CK2User *)lastEditedBy
{
    CK2User *user = [CK2User new];
    user.id = self.lastEditedByID;
    user.name = self.lastEditedByDisplayName;
    user.avatarURL = self.lastEditedByAvatarURL;
    
    return user;
}

- (NSString *)path
{
    NSString *path = self.context.path;
    path = [path stringByAppendingPathComponent:@"pages"];
    return [path stringByAppendingPathComponent:self.id];
}

@end
