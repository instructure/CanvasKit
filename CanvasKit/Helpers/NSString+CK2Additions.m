//
//  NSString+CK2Additions.m
//  OAuthTesting
//
//  Created by rroberts on 8/23/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "NSString+CK2Additions.h"

@implementation NSString (CK2Additions)

- (NSDictionary *)queryParameters {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        if (pair.length == 0) {
            continue;
        }
        NSArray *things = [pair componentsSeparatedByString:@"="];
        NSString *key = things[0];
        id value = @"";
        if (things.count > 1) {
            value = things[1];
        }
        dict[key] = value;
    }
    return dict;
}

@end
