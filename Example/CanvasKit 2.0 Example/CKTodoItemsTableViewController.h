//
//  CKTodoItemsTableViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKIClient;
@class CKICourse;

@interface CKTodoItemsTableViewController : UITableViewController

@property (nonatomic, strong) CKIClient *client;
@property (nonatomic, strong) NSArray *todoItems;
@property (nonatomic, strong) CKICourse *course;

@end
