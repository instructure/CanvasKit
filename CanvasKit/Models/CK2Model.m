//
//  CK2Model.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Model.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

@implementation CK2Model {
    id<CK2Context> _context;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[CK2Model class]]) {
        CK2Model *otherModel = (CK2Model *)object;
        return [self.id isEqualToString:otherModel.id];
    }
    return false;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)idJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

// Overridden to prevent NSInvalidArgumentException in cases where the API
// is returning 'null' for integral types. Mantle does not check to see if
// the type of the property is an object type before calling setValue:forKey:
- (void)setNilValueForKey:(NSString *)key
{
    [self setValue:@(0) forKey:key];
}

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionaryValue
{
    return [MTLJSONAdapter modelOfClass:self fromJSONDictionary:dictionaryValue error:nil];
}

#pragma mark - CK2Context implementation

- (void)setContext:(id<CK2Context>)context
{
    _context = context;
}

- (id<CK2Context>)context
{
    if (_context == nil) {
        return CK2RootContext;
    }
    
    return _context;
}

- (NSString *)path
{
    // subclasses must provide a path implementation.
    return nil;
}

@end


