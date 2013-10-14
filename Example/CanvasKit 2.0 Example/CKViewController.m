//
//  CKViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKViewController.h"
#import <CKLocalUser+Networking.h>
#import <ReactiveCocoa.h>
#import <CanvasKit.h>

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
    static NSString *Domain = nil; // @"school.instructure.com" (Optional)
    
    [CanvasKit prepareWithClientID:ClientID sharedSecret:SharedSecret];
    
    [[CKLocalUser sharedUser] performLoginWithDomain:Domain success:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"UserDetails" sender:sender];
    } failure:^(NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        switch (error.code) {
            case kCKErrorCodeUserCancelledOAuth:
                [self showErrorAlertWithMessage:@"You must login to proceed."];
                break;
            case kCKErrorCodeNotPreparedForOAuth:
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

@end
