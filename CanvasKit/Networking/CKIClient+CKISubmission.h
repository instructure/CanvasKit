//
//  CKIClient+CKISubmission.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@interface CKIClient (CKISubmission)

- (void)fetchSubmissionsForContext:(CKIModel *)context success:(void (^)(NSArray *submissions))success failure:(void (^)(NSError *error))failure;

@end
