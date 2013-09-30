//
//  ConvertorBrain.h
//  RLMoneyConvertor
//
//  Created by Rouli Zhou on 12/09/2013.
//  Copyright (c) 2013 Rouli Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertorBrain : NSObject 

@property (strong, nonatomic) NSString * fromCurrency;
@property (strong, nonatomic) NSString * toCurrency;
@property(assign,nonatomic)int amount;
@property (strong, nonatomic) NSArray *tempArray;

@property (strong, nonatomic) NSString * valueBeforeConverted;
@property (strong, nonatomic) NSString * valueAfterConverted;

@property (nonatomic, strong) NSMutableData *responseData;

-(id)initWithFromCurrency:(NSString *)fromCurrency
               toCurrency:(NSString *)toCurrency
               withAmount:(int)amount;

-(void)getConvertResult;
@end
