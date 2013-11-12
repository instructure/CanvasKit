//
//  CKIClient+CKIFile.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIFile;

@interface CKIClient (CKIFile)

- (void)fetchFile:(NSString *)fileID success:(void(^)(CKIFile *file))success failure:(void(^)(NSError *error))failure;

@end
