//
//  BujitStore.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import "BujitStore.h"
#import "BujitModel.h"

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
        
        NSString *path = [self itemArchivePath];
        _budgets = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!_budgets) {
            _budgets = [[NSMutableArray alloc]init];
        }
        
    }
    return self;
}

-(NSArray *)allItems {
    return [self.budgets copy];
}

-(void)addItem:(BujitModel *)newBudget {
    [self.budgets addObject:newBudget];
}


-(void)removeItemAtIndex: (NSUInteger)index {
    [self.budgets removeObjectAtIndex:index];
}

-(BujitModel *)objectAtIndex: (NSUInteger)index {
    return [self.budgets objectAtIndex:index];
}

#pragma mark - Archiving

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"budgets.archive"];
}

-(BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.budgets toFile:path];
}

@end
