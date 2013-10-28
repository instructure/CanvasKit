//
//  CKIModel.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CKIContext.h"

@interface CKIModel : MTLModel <MTLJSONSerializing, CKIContext>

/**
 The unique identifier assigned to this model.
 */
@property (nonatomic, copy) NSString *id;

/**
 Checks to see if two models are equivalent based on their ID.
 
 @param object the object to compare
 
 @returns true if objects have same IDs, else false.
 */
- (BOOL)isEqual:(id)object;
    

/**
 Convenience method for instantiating class from a JSON dictionary.
 */
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionaryValue;

@end
