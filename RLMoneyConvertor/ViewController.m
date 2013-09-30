//
//  ViewController.m
//  RLMoneyConvertor
//
//  Created by Rouli Zhou on 12/09/2013.
//  Copyright (c) 2013 Rouli Zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray * colCurrencies;
@end

@implementation ViewController

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame =CGRectOffset(banner.frame, 0, 50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.deviceHeight = 568.0f;
        NSLog(@"here");
    } else {
        self.deviceHeight = 480.0f;
        NSLog(@"44");
    }
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, self.deviceHeight);
    adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:adView];
    adView.delegate = self;
    self.bannerIsVisible = NO;

	[self setupPicker];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self initializeParams];
}

//init states
-(void)initializeParams
{
    self.fromCurrency = @"USD";
    self.toCurrency = @"USD";
    UIImage *fromImageFlagImage = [UIImage imageNamed:@"usd"];
    [self.fromImageFlag setImage:fromImageFlagImage];
    
    UIImage *toImageFlagImage = [UIImage imageNamed:@"usd"];
    [self.fromImageFlag setImage:toImageFlagImage];
}

-(void)dismissKeyboard {
    [self.fromField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setConvertorPicker:nil];
    [self setFromImageFlag:nil];
    [self setToImageFlag:nil];
    [self setFromField:nil];
    [self setToField:nil];
    [super viewDidUnload];
}

-(void)setupPicker
{
    self.convertorPicker.showsSelectionIndicator = TRUE;
    self.colCurrencies = [[NSArray alloc] initWithObjects:@"USD", @"GBP", @"CNY", @"JPY", @"EUR", nil];
}

- (IBAction)convertButton:(id)sender {

    //check only digits in string
    
    if ([[self.fromField text]rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
        [self drawFlag];
        [self.activity startAnimating];
        [self.convertButton setTitle:@"Converting..." forState:UIControlStateNormal];
        [self doConvertingAsync];
    }
    else
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Check your input value." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
        
    if ([self.fromField isFirstResponder]) {
        [self.fromField resignFirstResponder];
    }
}

- (void)doConvertingAsync
{
    dispatch_queue_t currencyFetchQueue = dispatch_queue_create("currency exchange fetcher", NULL);
    dispatch_async(currencyFetchQueue, ^{
        self.brain = [[ConvertorBrain alloc] initWithFromCurrency:self.fromCurrency toCurrency:self.toCurrency withAmount:[[self.fromField text] intValue]];
        [self.brain getConvertResult];
        if (![self.brain.valueAfterConverted isEqual:NULL]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.toField setText:self.brain.valueAfterConverted];
                [self.fromField setText:self.brain.valueBeforeConverted];
                [self.convertButton setTitle:@"convert" forState:UIControlStateNormal];
                [self.activity stopAnimating];
            });
        }
    });
    
}

-(void)drawFlag
{
    UIImage *fromImageFlagImage = [UIImage imageNamed:[self.fromCurrency lowercaseString]];
    [self.fromImageFlag setImage:fromImageFlagImage];
    
    UIImage *toImageFlagImage = [UIImage imageNamed:[self.toCurrency lowercaseString]];
    [self.toImageFlag setImage:toImageFlagImage];
}

//how many rows to display in each col
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.colCurrencies count];
    }
    return [self.colCurrencies count];
}

//number of col to display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//store value to nsstring
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.fromCurrency = [self.colCurrencies objectAtIndex:row];
    }else{
        self.toCurrency = [self.colCurrencies objectAtIndex:row];
    }
}


//to display on picker view
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.colCurrencies objectAtIndex:row];
    }
    return [self.colCurrencies objectAtIndex:row];
}


//text field delegates, Make sure keyboard will not cover the textfields
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
    if ([self.fromField isFirstResponder]) {
        [self.fromField resignFirstResponder];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 180;
    
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
