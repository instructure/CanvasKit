//
//  CKITab.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel.h"

@class CKICourse;

@interface CKITab : CKIModel

@property (nonatomic, strong) NSURL *htmlURL;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, strong) NSString *type;

@property (nonatomic) CKICourse *context;
@end
