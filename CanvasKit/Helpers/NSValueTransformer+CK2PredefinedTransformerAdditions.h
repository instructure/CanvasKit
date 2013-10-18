//
//  NSValueTransformer+CK2PredefinedTransformerAdditions.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/26/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The name for a value transfomer that converts NSNumbers to NSStrings and back.
 */
extern NSString * const CK2NumberStringTransformerName;

/**
 The name for a value transfomer that converts ISO8601 date-strings to NSDates and back.
 */
extern NSString * const CK2DateTransformerName;
