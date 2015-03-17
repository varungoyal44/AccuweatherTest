//
//  WeatherMapper.m
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import "WeatherMapper.h"
#import "NSString+TemperatureConversion.h"

@implementation WeatherMapper
- (id) initWithJSON:(NSDictionary *) responseJSON
{
    if(self = [super init])
    {
        _city = [responseJSON objectForKey:@"name"];
        
        _iconID = [[responseJSON objectForKey:@"weather"][0] objectForKey:@"icon"];
        
        _temperature = [[[responseJSON objectForKey:@"main"] objectForKey:@"temp"] stringValue];
        
        _minimumTemperature = [[[responseJSON objectForKey:@"main"] objectForKey:@"temp_min"] stringValue];
        
        _maximumTemperature = [[[responseJSON objectForKey:@"main"] objectForKey:@"temp_max"] stringValue];
        
        _condition = [[responseJSON objectForKey:@"weather"][0] objectForKey:@"description"];
        
        _humidity = [[[responseJSON objectForKey:@"main"] objectForKey:@"humidity"] stringValue];
        
        _windSpeed = [[[responseJSON objectForKey:@"wind"] objectForKey:@"speed"] stringValue];
        
        _windGust = [[[responseJSON objectForKey:@"wind"] objectForKey:@"gust"] stringValue];
        
        _windDirection = [[[responseJSON objectForKey:@"wind"] objectForKey:@"deg"] stringValue];
        
        if(_city.length == 0)
        {
            _city = [[responseJSON objectForKey:@"sys"] objectForKey:@"country"];
        }
    }
    return self;
}


-(NSString *) temperature
{
    return [_temperature convertToAbsoluteFahrenheit];
}

-(NSString *) minimumTemperature
{
    return [_minimumTemperature convertToAbsoluteFahrenheit];
}

-(NSString *) maximumTemperature
{
    return [_maximumTemperature convertToAbsoluteFahrenheit];
}
@end
