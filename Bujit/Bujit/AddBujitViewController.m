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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AddBujitViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.budgetNameTextfield.delegate = self;
    self.initialDepositTextField.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: tapGesture];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    if(textField == self.budgetNameTextfield) {
        [self.initialDepositTextField becomeFirstResponder];
    }
    
    return YES;
}

#pragma mark - UIGestureRecognizers

-(void)backgroundTap: (UIGestureRecognizer *) gr{
    [self.view endEditing:YES];
}

#pragma mark - Keyboard Notifications

-(void)keyboardDidShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }];
    
}

-(void)keyboardDidHide:(NSNotification *)note {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }];
    
}

@end
