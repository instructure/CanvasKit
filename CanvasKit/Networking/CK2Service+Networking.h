//
//  CK2Service+Networking.h
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Service.h"

@interface CK2Service (Networking)

+ (void)fetchServiceSuccess:(void (^)(CK2Service *service))success failure:(void (^)(NSError *error))failure;

@end
