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
    self.colCurrencies = [[NSArray alloc] initWithObjects:
                          @"United Arab Emirates Dirham (AED)",
                          @"Netherlands Antillean Guilder (ANG)",
                          @"Argentine Peso (ARS)",
                          @"Australian Dollar (AUD)",
                          @"Bangladeshi Taka (BDT)",
                          @"Bulgarian Lev (BGN)",
                          @"Bahraini Dinar (BHD)",
                          @"Brunei Dollar (BND)",
                          @"Bolivian Boliviano (BOB)",
                          @"Brazilian Real (BRL)",
                          @"Botswanan Pula (BWP)",
                          @"Canadian Dollar (CAD)",
                          @"Swiss Franc (CHF)",
                          @"Chilean Peso (CLP)",
                          @"Chinese Yuan (CNY)",
                          @"Colombian Peso (COP)",
                          @"Costa Rican Colón (CRC)",
                          @"Czech Republic Koruna (CZK)",
                          @"Danish Krone (DKK)",
                          @"Dominican Peso (DOP)",
                          @"Algerian Dinar (DZD)",
                          @"Estonian Kroon (EEK)",
                          @"Egyptian Pound (EGP)",
                          @"Euro (EUR)",
                          @"Fijian Dollar (FJD)",
                          @"British Pound Sterling (GBP)",
                          @"Hong Kong Dollar (HKD)",
                          @"Honduran Lempira (HNL)",
                          @"Croatian Kuna (HRK)",
                          @"Hungarian Forint (HUF)",
                          @"Indonesian Rupiah (IDR)",
                          @"Israeli New Sheqel (ILS)",
                          @"Indian Rupee (INR)",
                          @"Jamaican Dollar (JMD)",
                          @"Jordanian Dinar (JOD)",
                          @"Japanese Yen (JPY)",
                          @"Kenyan Shilling (KES)",
                          @"South Korean Won (KRW)",
                          @"Kuwaiti Dinar (KWD)",
                          @"Cayman Islands Dollar (KYD)",
                          @"Kazakhstani Tenge (KZT)",
                          @"Lebanese Pound (LBP)",
                          @"Sri Lankan Rupee (LKR)",
                          @"Lithuanian Litas (LTL)",
                          @"Latvian Lats (LVL)",
                          @"Moroccan Dirham (MAD)",
                          @"Moldovan Leu (MDL)",
                          @"Macedonian Denar (MKD)",
                          @"Mauritian Rupee (MUR)",
                          @"Maldivian Rufiyaa (MVR)",
                          @"Mexican Peso (MXN)",
                          @"Malaysian Ringgit (MYR)",
                          @"Namibian Dollar (NAD)",
                          @"Nigerian Naira (NGN)",
                          @"Nicaraguan Córdoba (NIO)",
                          @"Norwegian Krone (NOK)",
                          @"Nepalese Rupee (NPR)",
                          @"New Zealand Dollar (NZD)",
                          @"Omani Rial (OMR)",
                          @"Peruvian Nuevo Sol (PEN)",
                          @"Papua New Guinean Kina (PGK)",
                          @"Philippine Peso (PHP)",
                          @"Pakistani Rupee (PKR)",
                          @"Polish Zloty (PLN)",
                          @"Paraguayan Guarani (PYG)",
                          @"Qatari Rial (QAR)",
                          @"Romanian Leu (RON)",
                          @"Serbian Dinar (RSD)",
                          @"Russian Ruble (RUB)",
                          @"Saudi Riyal (SAR)",
                          @"Seychellois Rupee (SCR)",
                          @"Swedish Krona (SEK)",
                          @"Singapore Dollar (SGD)",
                          @"Slovak Koruna (SKK)",
                          @"Sierra Leonean Leone (SLL)",
                          @"Salvadoran Colón (SVC)",
                          @"Thai Baht (THB)",
                          @"Tunisian Dinar (TND)",
                          @"Turkish Lira (TRY)",
                          @"Trinidad and Tobago Dollar (TTD)",
                          @"New Taiwan Dollar (TWD)",
                          @"Tanzanian Shilling (TZS)",
                          @"Ukrainian Hryvnia (UAH)",
                          @"Ugandan Shilling (UGX)",
                          @"US Dollar (USD)",
                          @"Uruguayan Peso (UYU)",
                          @"Uzbekistan Som (UZS)",
                          @"Venezuelan Bolívar (VEF)",
                          @"Vietnamese Dong (VND)",
                          @"CFA Franc BCEAO (XOF)",
                          @"Yemeni Rial (YER)",
                          @"South African Rand (ZAR)",
                          @"Zambian Kwacha (ZMK)", nil];
    //    self.colCurrencies = [[NSArray alloc] initWithObjects:@"USD", @"GBP", @"CNY", @"JPY", @"EUR", nil];
}

-(NSString *)extractCurrencySign:(NSString *)currency
{
    NSString *resultString;
    
    NSRange startRange = [currency rangeOfString:@"("];
    NSRange searchRange = NSMakeRange(0, startRange.location);
    NSString *resultCurrencySign = [currency stringByReplacingCharactersInRange:searchRange withString:@""];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    resultString = [[resultCurrencySign componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    //    resultString = [resultCurrencySign stringByReplacingOccurrencesOfString:@"(" withString:@""];
    //    resultString = [resultCurrencySign stringByReplacingOccurrencesOfString:@")" withString:@""];
    return resultString;
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
        self.fromCurrency = [self extractCurrencySign:[self.colCurrencies objectAtIndex:row]];
    }else{
        self.toCurrency = [self extractCurrencySign:[self.colCurrencies objectAtIndex:row]];
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
