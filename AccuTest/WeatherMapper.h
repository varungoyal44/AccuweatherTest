//
//  WeatherMapper.h
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherMapper : NSObject

@property (nonatomic, strong) NSString *city; // City name

@property (nonatomic, strong) NSString *iconID; // Weather icon id

@property (nonatomic, strong) NSString *temperature; // Temperature, degree Fahrenheit

@property (nonatomic, strong) NSString *minimumTemperature; // Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)

@property (nonatomic, strong) NSString *maximumTemperature; // Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)

@property (nonatomic, strong) NSString *condition; // Weather condition within the group

@property (nonatomic, strong) NSString *humidity; // Humidity, %

@property (nonatomic, strong) NSString *windSpeed; // Wind speed, mps

@property (nonatomic, strong) NSString *windGust; // Wind gust, mps

@property (nonatomic, strong) NSString *windDirection; // Wind direction, degrees (meteorological)

- (id) initWithJSON:(NSDictionary *) responseJSON;

@end
