//
//  CK2Context.h
//  CanvasKit
//
//  Created by derrick on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CK2Context <NSObject>

/**
 The parent object of this object, if any.
 
 e.g. The parent object of a Submission is the Assignment object
 that was used to fetch it.
 */
@property (nonatomic) id<CK2Context> context;

/**
 The api path of the object.
 
 e.g. An assignment's path might be /api/v1/courses/823991/assignments/322
 */
@property (nonatomic, readonly) NSString *path;

@end

#import "CK2APIV1.h"
#define CK2RootContext [CK2APIV1 context]