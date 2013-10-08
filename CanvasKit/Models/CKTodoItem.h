//
//  CKTodoItem.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKTodoItem : CKModel

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSURL *ignore;

@property (nonatomic, strong) NSURL *ignorePermanently;

@property (nonatomic, strong) NSURL *htmlUrl;

@property (nonatomic) NSInteger needsGradingCount;

@property (nonatomic, strong) NSString *courseID;

@property (nonatomic, strong) NSString *contextType;

@property (nonatomic) NSInteger *groupID;

@end
