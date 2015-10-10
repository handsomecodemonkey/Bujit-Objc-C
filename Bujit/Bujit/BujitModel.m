//
//  BujitModel.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitModel.h"

@implementation BujitModel

-(NSString *)budgetAsString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    return [formatter stringFromNumber:self.budgetAmount];
}

@end
