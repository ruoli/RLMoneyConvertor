//
//  ConvertorBrain.m
//  RLMoneyConvertor
//
//  Created by Rouli Zhou on 12/09/2013.
//  Copyright (c) 2013 Rouli Zhou. All rights reserved.
//

#import "ConvertorBrain.h"

@implementation ConvertorBrain

-(id)initWithFromCurrency:(NSString *)fromCurrency
               toCurrency:(NSString *)toCurrency
               withAmount:(int)amount
{
    if (self=[super init]) {
        self.fromCurrency = fromCurrency;
        self.toCurrency = toCurrency;
        self.amount = amount;
    }
    return self;
}

-(void)getConvertResult
{
        NSString *searchLocation = [NSString stringWithFormat:@"http://rate-exchange.appspot.com/currency?from=%@&to=%@&q=%d", self.fromCurrency, self.toCurrency, self.amount];
        NSURL *convertedResults = [NSURL URLWithString:[searchLocation stringByAddingPercentEscapesUsingEncoding:
                                                        NSUTF8StringEncoding]];
        
        NSData *JSONData = [NSData dataWithContentsOfURL:convertedResults];
    
//    NSString *result = [[NSString alloc] initWithBytes:[JSONData bytes] length:[JSONData length] encoding:NSUTF8StringEncoding];
    NSError *error = NULL;
    //google is not sending valid JSOn so convert into valid JSON
//    NSString *resultdata = result;
//    resultdata = [resultdata stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
//    resultdata = [resultdata stringByReplacingOccurrencesOfString:@"," withString:@",\""];
//    resultdata = [resultdata stringByReplacingOccurrencesOfString:@":" withString:@"\":"];
    
//    NSData* data = [resultdata dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:JSONData
                          options:kNilOptions
                          error:&error];
    
    NSString* afterConvert =[NSString stringWithFormat:@"%@ : %@", self.toCurrency, [json objectForKey:@"v"]];
    NSString* initalValue = [NSString stringWithFormat:@"%@ : %d", self.fromCurrency, self.amount];
    if(error == nil){
        self.valueAfterConverted = afterConvert;
        self.valueBeforeConverted = initalValue;
    } else {
        NSLog(@"converted epic fail!!");
    }
}

@end
