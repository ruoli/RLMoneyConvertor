//
//  ViewController.h
//  RLMoneyConvertor
//
//  Created by Rouli Zhou on 12/09/2013.
//  Copyright (c) 2013 Rouli Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "ConvertorBrain.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,ADBannerViewDelegate,UITextFieldDelegate>
{
    ADBannerView *adView;
    BOOL bannaerIsVisible;
}
@property(assign,nonatomic)BOOL bannerIsVisible;
@property(assign,nonatomic)float deviceHeight;

@property (strong, nonatomic) IBOutlet UIPickerView *convertorPicker;
@property (strong, nonatomic) IBOutlet UIImageView *fromImageFlag;
@property (strong, nonatomic) IBOutlet UIImageView *toImageFlag;
@property (strong, nonatomic) IBOutlet UITextField *fromField;
@property (strong, nonatomic) IBOutlet UILabel *toField;

@property (strong, nonatomic) NSString * fromCurrency;
@property (strong, nonatomic) NSString * toCurrency;


@property(strong,nonatomic)ConvertorBrain * brain;

- (IBAction)convertButton:(id)sender;

@end
