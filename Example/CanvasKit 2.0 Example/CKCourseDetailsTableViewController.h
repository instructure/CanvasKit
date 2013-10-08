//
//  CKCourseDetailsTableViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CanvasKit.h>
#import <CKCourse.h>

@interface CKCourseDetailsTableViewController : UITableViewController

@property (nonatomic, strong) CKCourse *course;
@property (nonatomic, strong) NSMutableArray *courseItems;

@end
