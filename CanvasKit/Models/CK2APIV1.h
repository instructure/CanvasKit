//
//  CK2APIV1.h
//  CanvasKit
//
//  Created by derrick on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CK2Context.h"

@interface CK2APIV1 : NSObject <CK2Context>
+ (instancetype)context;
@end
