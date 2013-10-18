//
//  CK2Tab.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Model.h"

@interface CK2Tab : CK2Model

@property (nonatomic, strong) NSURL *htmlURL;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, strong) NSString *type;

@end
