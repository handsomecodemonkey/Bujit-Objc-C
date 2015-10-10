//
//  BujitModelTests.m
//  Bujit
//
//  Created by Erick Kusnadi on 10/9/15.
//  Copyright © 2015 Handsome Code Monkey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BujitModel.h"

@interface BujitModelTests : XCTestCase

@property(nonatomic,strong)BujitModel *bujitModel;

@end

@implementation BujitModelTests

- (void)setUp {
    [super setUp];
    self.bujitModel = [[BujitModel alloc]init];
}

- (void)tearDown {
    self.bujitModel = nil;
    [super tearDown];
}

- (void)testThatItReturnsStringFromNumber {
    
    self.bujitModel.budgetAmount = [NSNumber numberWithInt:100];
    NSString *amountAsString = [self.bujitModel budgetAsString];
    XCTAssert([amountAsString isEqualToString:@"$100.00"]);
    
}

@end
