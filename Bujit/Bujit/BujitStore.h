//
//  BujitStore.h
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BujitStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;

+(instancetype)sharedStore;

@end
