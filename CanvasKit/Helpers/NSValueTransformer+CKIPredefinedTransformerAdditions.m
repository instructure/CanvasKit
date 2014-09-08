//
//  NSValueTransformer+CKIPredefinedTransformerAdditions.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/26/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"
#import "ISO8601DateFormatter.h"

NSString * const CKINumberStringTransformerName = @"CKINumberStringTransformerName";
NSString * const CKINumberOrStringToStringTransformerName = @"CKINumberOrStringToStringTransformerName";
NSString * const CKIDateTransformerName = @"CKIDateTransformerName";

@implementation NSValueTransformer (CKIPredefinedTransformerAdditions)

#pragma mark Category Loading

+ (void)load {
	@autoreleasepool {
		MTLValueTransformer *NumberStringTransformer = [NSValueTransformer numberStringTransformer];
		
		[NSValueTransformer setValueTransformer:NumberStringTransformer forName:CKINumberStringTransformerName];
        
        MTLValueTransformer *NumberOrStringToStringTransformer = [NSValueTransformer numberOrStringToStringTransformer];
        
        [NSValueTransformer setValueTransformer:NumberOrStringToStringTransformer forName:CKINumberOrStringToStringTransformerName];
        
		MTLValueTransformer *ISODateTransfomer = [NSValueTransformer ISODateTransformer];
        
		[NSValueTransformer setValueTransformer:ISODateTransfomer forName:CKIDateTransformerName];
	}
}

+ (MTLValueTransformer *)numberStringTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^ id (NSNumber *number) {
        return [number stringValue];
    } reverseBlock:^ id (NSString *stringifiedNumber) {
        return [NSNumber numberWithLongLong:[stringifiedNumber longLongValue]];
    }];
}

+ (MTLValueTransformer *)numberOrStringToStringTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^ id (id value) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value stringValue];
        }

        return value;
    } reverseBlock:^ id (NSString *stringifiedNumber) {
        return stringifiedNumber;
    }];
}

+ (MTLValueTransformer *)ISODateTransformer;
{
    static ISO8601DateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [ISO8601DateFormatter new];
        dateFormatter.includeTime = YES;
    });
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateString) {
        if (dateString == nil) {
            return nil;
        }
        return [dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date) {
        if (date == nil) {
            return nil;
        }
        return [dateFormatter stringFromDate:date];
    }];
}

@end
