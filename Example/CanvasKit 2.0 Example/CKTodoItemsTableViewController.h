//
//  CKTodoItemsTableViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CKCourse.h>

@interface CKTodoItemsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *todoItems;
@property (nonatomic, strong) CKCourse *course;

@end
