//
//  AddBujitViewController.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "AddBujitViewController.h"
#import "BujitStore.h"
#import "BujitModel.h"

@interface AddBujitViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *budgetNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *initialDepositTextField;

@end

@implementation AddBujitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.budgetNameTextfield.delegate = self;
    self.initialDepositTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewBudget:(UIButton *)sender {
    if(self.budgetNameTextfield.text.length == 0) {
        self.budget.budgetName = @"My Budget";
    } else {
        self.budget.budgetName = self.budgetNameTextfield.text;
    }
    
    if(self.initialDepositTextField.text.length == 0) {
        self.budget.budgetAmount = [NSNumber numberWithInt:0];
    } else {
        self.budget.budgetAmount = [NSNumber numberWithDouble:self.initialDepositTextField.text.doubleValue];
    }
    
    [[BujitStore sharedStore]addItem:self.budget];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
