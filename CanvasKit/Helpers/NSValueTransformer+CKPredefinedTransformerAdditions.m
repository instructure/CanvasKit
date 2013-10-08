//
//  NSValueTransformer+CKPredefinedTransformerAdditions.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/26/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"
#import "ISO8601DateFormatter.h"

NSString * const CKNumberStringTransformerName = @"CKNumberStringTransformerName";
NSString * const CKDateTransformerName = @"CKDateTransformerName";

@implementation NSValueTransformer (CKPredefinedTransformerAdditions)

#pragma mark Category Loading

+ (void)load {
	@autoreleasepool {
		MTLValueTransformer *NumberStringTransformer = [NSValueTransformer numberStringTransformer];
		
		[NSValueTransformer setValueTransformer:NumberStringTransformer forName:CKNumberStringTransformerName];
        
		MTLValueTransformer *ISODateTransfomer = [NSValueTransformer ISODateTransformer];
        
		[NSValueTransformer setValueTransformer:ISODateTransfomer forName:CKDateTransformerName];
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

+ (MTLValueTransformer *)ISODateTransformer;
{
    static ISO8601DateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [ISO8601DateFormatter new];
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
