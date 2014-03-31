//
//  CKIClient+CKIFile.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIFile;
@class RACSignal;

@interface CKIClient (CKIFile)

- (RACSignal *)fetchFile:(NSString *)fileID;
- (RACSignal *)deleteFile:(CKIFile *)file;

@end
