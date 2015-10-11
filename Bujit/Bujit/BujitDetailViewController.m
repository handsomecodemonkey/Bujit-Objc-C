//
//  BujitDetailViewController.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitDetailViewController.h"
#import "BujitModel.h"

@interface BujitDetailViewController ()

@end

@implementation BujitDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
