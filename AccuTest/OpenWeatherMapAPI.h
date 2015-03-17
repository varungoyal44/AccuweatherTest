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


@interface OpenWeatherMapAPI : NSObject
-(id) initWithLocation:(LocationMapper *) location;
-(void) getCurrentWeatherWithCompletionHandler:(CurrentWeatherCompletionHandler) completionHandler;

@end
