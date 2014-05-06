//
//  CKIClient+CKISubmission.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIAssignment;

@interface CKIClient (CKISubmission)

- (RACSignal *)fetchSubmissionsForAssignment:(CKIAssignment *)assignment;

@end
