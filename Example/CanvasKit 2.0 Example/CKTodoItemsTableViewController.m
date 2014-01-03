//
//  CKTodoItemsTableViewController.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKTodoItemsTableViewController.h"
#import <CanvasKit/CanvasKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CKTodoItemsTableViewController ()

@end

@implementation CKTodoItemsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TodoItemCell"];
    
    self.todoItems = [NSMutableArray array];
    
    RACSignal *todoItemsSignal;
    
    if (self.course) {
        todoItemsSignal = [self.client fetchTodoItemsForCourse:self.course];
    }
    else {
        todoItemsSignal = [self.client fetchTodoItemsForCurrentUser];
    }

    [todoItemsSignal subscribeNext:^(id todoItems) {
        [self.todoItems addObjectsFromArray:todoItems];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"Error fetching the todo items.");
    }];

}

- (NSMutableArray *)todoItems
{
    if (!_todoItems) {
        _todoItems = [NSMutableArray new];
    }
    return _todoItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TodoItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CKITodoItem *item = [self.todoItems objectAtIndex:indexPath.row];
    [cell.textLabel setText:item.type];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, cell.frame.size.height)];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setText:[NSString stringWithFormat:@"%@", item.courseID]];
    [cell setAccessoryView:label];
    return cell;
}

@end
