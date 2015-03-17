//
//  OpenWeatherMapAPI.h
//  AccuTest
//
//  Created by Varun Goyal on 3/15/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationMapper.h"
#import "WeatherMapper.h"

typedef void (^CurrentWeatherCompletionHandler)(WeatherMapper* currentWeather, NSString *errorMessage);
typedef void (^WeatherIconCompletionHandler)(id weatherIcon, NSString *errorMessage);

@interface OpenWeatherMapAPI : NSObject
/**
 To initialize an object of open weather map api.
 
 @param location is the location for which the apis will need to be called.
 */
-(id) initWithLocation:(LocationMapper *) location;


/**
 To get the current weather condition of a location saved during initialization.
 
 @param completionHandler block will be called when the weather api returns.
 */
-(void) getCurrentWeatherWithCompletionHandler:(CurrentWeatherCompletionHandler) completionHandler;


/**
 To get the image from openweathermap.
 
 @param iconID is the id of the image to be grabbed.
 @param completionHandler block will be called once the api returns.
 */
-(void) getImageWithIconID:(NSString *) iconID withCompletionHandler:(WeatherIconCompletionHandler) completionHandler;
@end
