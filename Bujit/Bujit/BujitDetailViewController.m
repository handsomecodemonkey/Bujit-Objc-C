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

@end

@implementation BujitDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    
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
    self.mainToolbar.hidden = NO;
    [self.amountTextField becomeFirstResponder];
}

- (IBAction)subtractMoney:(UIButton *)sender {
    
}

- (IBAction)keyboardDoneEditing:(id)sender {
    self.mainToolbar.hidden = YES;
    [self.amountTextField resignFirstResponder];
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
    
    CGRect messageFrame = self.mainToolbar.frame;
    messageFrame.origin.y -= keyboardRect.size.height;
    [self.mainToolbar setFrame:messageFrame];
}

-(void)keyboardDidHide:(NSNotification *)note {
    NSDictionary *info = [note userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }];
    
    CGRect messageFrame = self.mainToolbar.frame;
    messageFrame.origin.y += keyboardRect.size.height;
    [self.mainToolbar setFrame:messageFrame];
}

@end
