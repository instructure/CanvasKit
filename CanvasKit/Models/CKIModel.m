//
//  CKIModel.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"

@implementation CKIModel {
    id<CKIContext> _context;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[CKIModel class]]) {
        CKIModel *otherModel = (CKIModel *)object;
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
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
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

#pragma mark - CKIContext implementation

- (void)setContext:(id<CKIContext>)context
{
    _context = context;
}

- (id<CKIContext>)context
{
    if (_context == nil) {
        return CKIRootContext;
    }
    
    return _context;
}

- (NSString *)path
{
    // subclasses must provide a path implementation.
    return nil;
}

@end


