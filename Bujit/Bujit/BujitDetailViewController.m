//
//  BujitDetailViewController.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitDetailViewController.h"
#import "BujitModel.h"
#import "BujitStore.h"

@interface BujitDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIToolbar *mainToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, strong) NSNumber *amountCopy;
@property(nonatomic) BOOL addingMoney;
@property(nonatomic, strong)NSNumberFormatter *formatter;

@property(nonatomic) UIEdgeInsets defaultInsets;

@end

@implementation BujitDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.amountTextField.delegate = self;
    
    self.formatter = [[NSNumberFormatter alloc]init];
    [self.formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    self.amountCopy = [self.formatter numberFromString:self.amountTextField.text];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initializers

-(instancetype)init {
    BujitModel *newBudget = [[BujitModel alloc]init];
    return [self initWithModel:newBudget];
}

//Designated initializer and constructor injection
-(instancetype)initWithModel:(BujitModel *)budget {
    self = [super init];
    if(self){
        _budget = budget;
    }
    return self;
}

#pragma mark - Buttons
- (IBAction)addMoreMoney:(UIButton *)sender {
    self.addingMoney = YES;
    self.mainToolbar.hidden = NO;
    [self.amountTextField becomeFirstResponder];
}

- (IBAction)subtractMoney:(UIButton *)sender {
    self.addingMoney = NO;
    self.mainToolbar.hidden = NO;
    [self.amountTextField becomeFirstResponder];
}

- (IBAction)keyboardDoneEditing:(id)sender {
    self.mainToolbar.hidden = YES;
    [self.amountTextField resignFirstResponder];
    
    if(self.amountTextField.text.length == 0) {
        return;
    }
    
    self.amountCopy = [self.formatter numberFromString:self.budgetAmountLabel.text];
    double amount = [self.amountTextField.text doubleValue];
    amount = self.addingMoney ? amount : -amount;
    NSNumber *newAmount = [NSNumber numberWithDouble:(self.amountCopy.doubleValue + amount)];
    NSString *newAmountString = [self.formatter stringFromNumber:newAmount];
    self.budget.budgetAmount = newAmount;
    self.budgetAmountLabel.text = newAmountString;
    
    self.amountTextField.text = @"";
}

-(void)backgroundTapped: (UIGestureRecognizer *)gestureRecognizer {
    self.mainToolbar.hidden = YES;
    [self.view endEditing:YES];
    self.amountTextField.text = @"";
}

#pragma mark - UITextFieldDelegate

/*
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
}
 */

#pragma mark - Keyboard Notifications

-(void)keyboardDidShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0);
    
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.0 options:0 animations:^{
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }completion:NULL];
    
    CGRect messageFrame = self.mainToolbar.frame;
    messageFrame.origin.y -= keyboardRect.size.height;
    [self.mainToolbar setFrame:messageFrame];
}

-(void)keyboardDidHide:(NSNotification *)note {
    NSDictionary *info = [note userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect messageFrame = self.mainToolbar.frame;
    messageFrame.origin.y += keyboardRect.size.height;
    [self.mainToolbar setFrame:messageFrame];
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.0 options:0 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, -self.navigationController.navigationBar.frame.size.height) animated:NO];
    }completion:NULL];
    
}

@end
