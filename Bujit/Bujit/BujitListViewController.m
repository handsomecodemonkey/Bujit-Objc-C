//
//  BujitListViewController.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitListViewController.h"
#import "AddBujitViewController.h"
#import "BujitDetailViewController.h"
#import "BujitStore.h"
#import "BujitModel.h"

@interface BujitListViewController ()

@end

@implementation BujitListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addNewBudgetButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewBudget:)];
    
    self.navigationItem.rightBarButtonItem = addNewBudgetButtonItem;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [BujitStore sharedStore].allItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BujitModel *bujitModel = [BujitStore sharedStore].allItems[indexPath.row];
    cell.textLabel.text = bujitModel.budgetName;
    cell.detailTextLabel.text = [bujitModel budgetAsString];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[BujitStore sharedStore]removeItemAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BujitDetailViewController *detailViewController = [[BujitDetailViewController alloc]initWithModel:[[BujitStore sharedStore]objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    self.navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    self.navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
}

// Override to support rearranging the table view.
/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {

}
*/


// Override to support conditional rearranging of the table view.
/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation and Navigation Buttons

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)addNewBudget:(id)sender {
    AddBujitViewController *newBujit = [[AddBujitViewController alloc]init];
    newBujit.title = @"New Budget";
    newBujit.budget = [[BujitModel alloc]init];
    
    [self.navigationController pushViewController:newBujit animated:YES];
}

@end
