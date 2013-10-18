//
//  CKService.m
//  CanvasKit
//
//  Created by Miles Wright on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKService.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKService

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"partnerID": @"partner_id",
                               @"resourceDomain": @"resource_domain",
                               @"rmtpDomain": @"rmtp_domain"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)domainJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)resourceDomainJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)rmtpDomainJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
