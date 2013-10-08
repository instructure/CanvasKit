//
//  CKTab.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKTab : CKModel

@property (nonatomic, strong) NSURL *htmlURL;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, strong) NSString *type;

@end
