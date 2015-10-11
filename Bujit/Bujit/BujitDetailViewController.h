//
//  BujitDetailViewController.h
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BujitModel;

@interface BujitDetailViewController : UIViewController

@property (nonatomic, strong) BujitModel *budget;

-(instancetype)initWithModel: (BujitModel *)budget;

@end
