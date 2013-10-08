//
//  CKAssignmentsTableViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CKAssignment.h>
#import <CKAssignment+Networking.h>

@interface CKAssignmentsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *assignments;

@end
