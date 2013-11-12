//
//  CKIClient+CKITab.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKITab.h"
#import "CKITab.h"
#import "CKICourse.h"

@implementation CKIClient (CKITab)

- (void)fetchTabsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITab class] context:course success:success failure:failure];
}

@end
