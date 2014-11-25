//
//  CKIXMLParser.m
//  CanvasKit
//
//  Created by Rick Roberts on 11/25/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIXMLParser.h"

@interface CKIXMLParser() <NSXMLParserDelegate>

@end

@implementation CKIXMLParser

- (void)parseShiz:(id)shiz {
    
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:shiz];
    
    parser.delegate = self;
    
    BOOL success = [parser parse];
    if (success) {
        NSLog(@"Parsed");
    } else {
        NSLog(@"Failed to parse");
    }
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"NAME: %@", elementName);
}

@end
