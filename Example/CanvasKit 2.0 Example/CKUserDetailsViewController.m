//
//  CKUserDetailsViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa.h>
#import <CoreGraphics/CoreGraphics.h>

#import "CKUserDetailsViewController.h"
#import "CKTodoItemsTableViewController.h"
#import "CKCourseDetailsTableViewController.h"

@interface CKUserDetailsViewController ()

@end

@implementation CKUserDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    CALayer *layer = [self.profileImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.profileImageView.frame.size.width / 2];
    [layer setBorderWidth:2];
    [layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    RAC(self, title) = RACObserve(self, client.currentUser.name);
    RAC(self, nameLabel.text) = RACObserve(self, client.currentUser.name);
    RAC(self, descriptionLabel.text) = RACObserve(self, client.currentUser.email);
}

- (IBAction)logoutUser:(id)sender
{
    [self.client logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)viewTodoItems:(id)sender
{
    CKTodoItemsTableViewController *controller = [[CKTodoItemsTableViewController alloc] init];
    controller.client = self.client;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushCourses"]) {
        CKCourseDetailsTableViewController *vc = segue.destinationViewController;
        vc.client = self.client;
    }
}

@end
