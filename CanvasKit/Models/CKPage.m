//
//  CKPage.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKPage.h"
#import "CKUser.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

@interface CKPage()
// these are private properties used to store the JSON values
// and used to create the derived lastEditedBy property.
@property (nonatomic, copy) NSString *lastEditedByID;
@property (nonatomic, copy) NSString *lastEditedByDisplayName;
@property (nonatomic, strong) NSURL *lastEditedByAvatarURL;
@end

@implementation CKPage

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
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)lastEditedByIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)lastEditedByAvatarURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (CKUser *)lastEditedBy
{
    CKUser *user = [CKUser new];
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
