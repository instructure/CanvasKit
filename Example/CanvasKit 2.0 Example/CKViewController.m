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
    static NSString *ClientID = @"Your client ID";
    static NSString *SharedSecret = @"Your shared secret here";
    static NSString *Domain = @"school.instructure.com";
    
    [CanvasKit prepareWithClientID:ClientID sharedSecret:SharedSecret domain:Domain];
    
    [[CKLocalUser sharedUser] performLoginWithSuccess:^{
        [self performSegueWithIdentifier:@"UserDetails" sender:sender];
    } failure:^(NSError *error) {
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
