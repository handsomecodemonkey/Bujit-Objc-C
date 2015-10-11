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

#pragma mark - Archiving

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.budgetName forKey:@"budgetName"];
    [aCoder encodeObject:self.budgetAmount forKey:@"budgetAmount"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self){
        _budgetName = [aDecoder decodeObjectForKey:@"budgetName"];
        _budgetAmount = [aDecoder decodeObjectForKey:@"budgetAmount"];
    }
    return self;
}

@end
