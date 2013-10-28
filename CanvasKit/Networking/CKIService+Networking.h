//
//  CKIService+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIService.h"

@interface CKIService (Networking)

+ (void)fetchServiceSuccess:(void (^)(CKIService *service))success failure:(void (^)(NSError *error))failure;

@end
