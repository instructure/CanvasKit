//
//  CKUserDetailsViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKUserDetailsViewController.h"
#import <ReactiveCocoa.h>

#import <CKLocalUser+Networking.h>
#import <CoreGraphics/CoreGraphics.h>

#import "CKTodoItemsTableViewController.h"

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
    
    self.user = [CKLocalUser sharedUser];
    self.title = self.user.name;
    self.navigationItem.hidesBackButton = YES;
    
    CALayer *layer = [self.profileImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.profileImageView.frame.size.width / 2];
    [layer setBorderWidth:2];
    [layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
    [RACAble(self.user.name) subscribeNext:^(id x) {
        [self setTitle:self.user.name];
    }];
    
    [self.user fetchAttributesWithsuccess:^{
        [self.profileImageView setImageWithURL:self.user.avatarURL];
        [self.nameLabel setText:self.user.name];
        [self.descriptionLabel setText:@"This is a temporary description for the user"];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not get user info" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutUser:(id)sender
{
    NSLog(@"IS LOGGED IN?: %d", self.user.isLoggedIn);
}

- (IBAction)viewTodoItems:(id)sender
{
    CKTodoItemsTableViewController *controller = [[CKTodoItemsTableViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
