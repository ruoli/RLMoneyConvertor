//
//  RLMoneyConvertorTests.m
//  RLMoneyConvertorTests
//
//  Created by Rouli Zhou on 12/09/2013.
//  Copyright (c) 2013 Rouli Zhou. All rights reserved.
//

#import "RLMoneyConvertorTests.h"

@implementation RLMoneyConvertorTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    self.brain = [[ConvertorBrain alloc] initWithFromCurrency:@"GBP" toCurrency:@"JPY" withAmount:100];
    [self.brain getConvertResult];
    STAssertEqualObjects(self.brain.valueAfterConverted, @"62.9802242 British pounds", @"testresult gonna have some value back...");
}



@end
