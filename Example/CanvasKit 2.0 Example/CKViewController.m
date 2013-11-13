//
//  CKViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa.h>

#import "CKViewController.h"
#import "CKUserDetailsViewController.h"

@interface CKViewController ()

@end

@implementation CKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Canvas Kit Example";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
    static NSString *ClientID = nil; // Your Client ID
    static NSString *SharedSecret = nil; // Your shared secret here
    static NSString *Domain = nil; // @"https://school.instructure.com"
    NSURL *url = [NSURL URLWithString:Domain];
    
    
    
    self.client = [CKIClient clientWithBaseURL:url clientID:ClientID sharedSecret:SharedSecret];
    [self.client loginWithSuccess:^{
        [self performSegueWithIdentifier:@"UserDetails" sender:sender];
    } failure:^(NSError *error) {
        switch (error.code) {
            case kCKIErrorCodeUserCancelledOAuth:
                [self showErrorAlertWithMessage:@"You must login to proceed."];
                break;
            case kCKIErrorCodeNotPreparedForOAuth:
                [self showErrorAlertWithMessage:@"Your application developer should prepare for OAuth before attempting to login the user."];
            default:
                break;
        }
    }];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UserDetails"]) {
        CKUserDetailsViewController *detailsVC = segue.destinationViewController;
        detailsVC.client = self.client;
    }
}

@end
