//
//  BujitStore.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitStore.h"

@interface BujitStore()

@property (nonatomic) NSMutableArray *budgets;

@end


@implementation BujitStore

+(instancetype)sharedStore {
    static BujitStore *sharedStore;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[BujitStore alloc]initPrivate];
    });
    
    return sharedStore;
}

-(instancetype)init {
    [NSException raise:@"Singleton" format:@"Use [BujitStore sharedStore]"];
    return nil;
}

-(instancetype)initPrivate {
    self = [super init];
    if(self){
        _budgets = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray *)allItems {
    return [self.budgets copy];
}

@end
