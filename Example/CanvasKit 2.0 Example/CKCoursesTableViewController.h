//
//  CKCoursesTableViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKIClient;

@interface CKCoursesTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *courses;

@property (nonatomic, strong) CKIClient *client;

@end
