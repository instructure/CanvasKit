//
//  CKIModel+Networking.h
//  CanvasKit
//
//  Created by derrick on 11/5/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel.h"
#import "CKIPagedResponse.h"

@interface CKIModel (Networking)
- (void)refreshWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
@end
