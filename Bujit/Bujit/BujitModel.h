//
//  BujitModel.h
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BujitModel : NSObject

@property(nonatomic,strong) NSString *budgetName;
@property(nonatomic,strong) NSNumber *budgetAmount;

-(NSString *)budgetAsString;

@end
