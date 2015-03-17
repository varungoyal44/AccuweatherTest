//
//  MainViewController.m
//  AccuTest
//
//  Created by Varun Goyal on 3/13/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

@import CoreLocation;
#import "MainViewController.h"
#import "LocationChoiceViewController.h"
#import "LocationMapper.h"
#import "OpenWeatherMapAPI.h"
#import <SVProgressHUD/SVProgressHUD.h>
#define bufferSpace 50



@interface MainViewController () <UIScrollViewDelegate, LocationChoiceProtocol>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lbMinMax;
@property (weak, nonatomic) IBOutlet UILabel *lbCondition;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeatherIcon;

@property (weak, nonatomic) IBOutlet UILabel *lbHumidityValue;
@property (weak, nonatomic) IBOutlet UILabel *lbWindSpeedValue;
@property (weak, nonatomic) IBOutlet UILabel *lbWindGustValue;
@property (weak, nonatomic) IBOutlet UILabel *lbWindDirectionValue;
@property (weak, nonatomic) IBOutlet UITextField *tfLocationName;
@property (weak, nonatomic) IBOutlet UIButton *buttonGetWeather;

@property (nonatomic, strong) NSMutableArray *addressFound;
@end




@implementation MainViewController
#pragma mark- LIFECYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize...
    self.addressFound = [NSMutableArray array];
    
    // To set content size of scroll view...
    CGSize scrollViewSize = self.buttonGetWeather.frame.size;
    scrollViewSize.height = scrollViewSize.height + 30;
    [self.scrollView setContentSize:scrollViewSize];
    [self.scrollView setScrollEnabled:YES];
    
    // To add notifications for Keyboard...
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // To add notification for on touch on scroll view...
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTouched)];
    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    // To set default values...
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    LocationMapper *defaultLocation = [[LocationMapper alloc] init];
    [defaultLocation setCity:@"State College"];
    [defaultLocation setState:@"PA"];
    [self updateWeatherInfoForLocation:defaultLocation];
}




#pragma mark- Actions
- (IBAction)buttonGetWeatherPushed:(id)sender
{
    // To hide the keyboard...
    [self scrollViewTouched];
    
    // if there was no new location entered...
    if(self.tfLocationName.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please enter a valid location"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    // To display the activiy indicator...
    [SVProgressHUD show];
    [SVProgressHUD setStatus:@"looking up location"];
    
    
    /*
     Note: this is not the perfect solution, but good for Demo purposes only. As from apple docs for geocodeAddressString:completionHandler:
     Geocoding requests are rate-limited for each app, so making too many requests in a short period of time may cause some of the requests to fail. When the maximum rate is exceeded, the geocoder passes an error object with the value kCLErrorNetwork to your completion handler.
     */
    // To lookup location name...
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:self.tfLocationName.text completionHandler: ^(NSArray *placemarks, NSError *error) {
        // if locations are found...
        if (placemarks && placemarks.count > 0)
        {
            // To get all the valid locations...
            [self.addressFound removeAllObjects];
            for (CLPlacemark *thisPlacemark in placemarks)
            {
                LocationMapper *thisLocation = [[LocationMapper alloc] initWithPlacemarkDictionary:thisPlacemark.addressDictionary];
                [self.addressFound addObject:thisLocation];
            }
            
            if(self.addressFound.count == 1)
            {
                // To update weather info...
                [SVProgressHUD setStatus:@"found location"];
                [self updateWeatherInfoForLocation:self.addressFound[0]];
            }
            else
            {
                // If more than one location, give the user an option to choose...
                [SVProgressHUD showInfoWithStatus:@"found multiple locations"];
                [self performSegueWithIdentifier:@"locationChoiceSegue" sender:self];
            }
        }
        else
        {
            // the location was not found for some reason still try and get the weather...
            [SVProgressHUD setStatus:@"could not find location"];
            LocationMapper *thisLocation = [[LocationMapper alloc] init];
            thisLocation.city = self.tfLocationName.text;
            [self updateWeatherInfoForLocation:thisLocation];
        }
        
        if(error)
        {
            NSLog(@"Error response from CLGeoCoder:%@ ", [error description]);
        }
    }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"locationChoiceSegue"])
    {
        LocationChoiceViewController *locationChoiceVC = (LocationChoiceViewController *)[segue destinationViewController];
        locationChoiceVC.addresses = self.addressFound;
        locationChoiceVC.delegate = self;
    }
}

-(void) didSelectLocation:(LocationMapper *) location
{
    [self updateWeatherInfoForLocation:location];
}

#pragma mark- keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *information = [notification userInfo];
    CGSize keyboardSize = [[information objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect aRect = self.view.frame;
    aRect.size.height = aRect.size.height - keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.buttonGetWeather.frame.origin))
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.buttonGetWeather.frame.origin.y - keyboardSize.height + bufferSpace);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}




#pragma mark- Utility
-(void) scrollViewTouched
{
    [self.view endEditing:YES];
}

-(void) updateWeatherInfoForLocation:(LocationMapper *) newLocation
{
    // To reset if no location is provided...
    if(!newLocation)
    {
        self.lbCity.text =
        self.lbTemperature.text =
        self.lbMinMax.text =
        self.lbCondition.text =
        self.lbHumidityValue.text =
        self.lbWindSpeedValue.text =
        self.lbWindGustValue.text =
        self.lbWindDirectionValue.text = @"n/a";
        return;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD setStatus:@"getting weather data"];
    
    // To get weather data from Open weather map API...
    OpenWeatherMapAPI *openWeatherMapAPI = [[OpenWeatherMapAPI alloc] initWithLocation:newLocation];
    [openWeatherMapAPI getCurrentWeatherWithCompletionHandler:^(WeatherMapper *currentWeather, NSString *errorMessage)
     {
         if(currentWeather)
         {
             // To get weather icon if exists...
             if(currentWeather.iconID.length > 0)
             {
                 [openWeatherMapAPI getImageWithIconID:currentWeather.iconID
                                 withCompletionHandler:^(id weatherIcon, NSString *errorMessage) {
                                     if(weatherIcon && [[weatherIcon class] isSubclassOfClass:[UIImage class]])
                                     {
                                         [self.imgWeatherIcon setImage:weatherIcon];
                                     }
                                     else
                                     {
                                         [SVProgressHUD showErrorWithStatus:errorMessage];
                                     }
                                 }];
             }
             
             // To display city...
             self.lbCity.text = currentWeather.city;
             
             // To display temperatures...
             self.lbTemperature.text = [NSString stringWithFormat:@"%@°", currentWeather.temperature];
             self.lbMinMax.text = [NSString stringWithFormat:@"%@°/%@°", currentWeather.minimumTemperature, currentWeather.maximumTemperature];
             
             // To display current condition...
             self.lbCondition.text = currentWeather.condition;
             
             // To display humidity...
             if(currentWeather.humidity.length > 0)
             {
                 self.lbHumidityValue.text = [NSString stringWithFormat:@"%@%%", currentWeather.humidity];
             }
             else
             {
                 self.lbHumidityValue.text = @"-";
             }
             
             // To display wind speed...
             if(currentWeather.windSpeed.length > 0)
             {
                 self.lbWindSpeedValue.text = [NSString stringWithFormat:@"%@ mps",currentWeather.windSpeed];
             }
             else
             {
                 self.lbWindSpeedValue.text = @"-";
             }
             
             // To display wind gust...
             if(currentWeather.windGust.length > 0)
             {
                 self.lbWindGustValue.text = [NSString stringWithFormat:@"%@ mps", currentWeather.windGust];
             }
             else
             {
                 self.lbWindGustValue.text = @"-";
             }
             
             // To display wind direction...
             if(currentWeather.windDirection.length > 0)
             {
                 self.lbWindDirectionValue.text = [NSString stringWithFormat:@"%@°",currentWeather.windDirection];
             }
             else
             {
                 self.lbWindDirectionValue.text = @"-";
             }
             
             // To stop SVProgressHUD...
             [SVProgressHUD showSuccessWithStatus:@"done"];
             
             // To clear the text field...
             [self.tfLocationName setText:@""];
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:errorMessage];
         }
     }];
}

@end
