//
//  CKCoursesTableViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <CanvasKit/CanvasKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKCoursesTableViewController.h"
#import "CKCourseDetailsTableViewController.h"

@interface CKCoursesTableViewController ()

@end

@implementation CKCoursesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self.client fetchCoursesForCurrentUser] subscribeNext:^(NSArray *courses) {
        [self.courses addObjectsFromArray:courses];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not get courses" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (NSMutableArray *)courses
{
    if (!_courses) {
        _courses = [NSMutableArray new];
    }
    return _courses;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CKICourse *course = [self.courses objectAtIndex:indexPath.row];
    
    // Configure the cell...
    [cell.textLabel setText:course.name];
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CKCourseDetailsTableViewController *detailController = [segue destinationViewController];
    [detailController setCourse:[self.courses objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
}


@end
