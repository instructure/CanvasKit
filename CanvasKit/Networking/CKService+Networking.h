//
//  CKService+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKService.h"

@interface CKService (Networking)

+ (void)fetchServiceSuccess:(void (^)(CKService *service))success failure:(void (^)(NSError *error))failure;

@end
