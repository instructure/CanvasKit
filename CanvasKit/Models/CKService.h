//
//  CKService.h
//  CanvasKit
//
//  Created by Miles Wright on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKService : CKModel

@property (nonatomic, copy) NSURL *domain;

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, copy) NSString *partnerID;

@property (nonatomic, strong) NSURL *resourceDomain;

@property (nonatomic, strong) NSURL *rmtpDomain;

@end
