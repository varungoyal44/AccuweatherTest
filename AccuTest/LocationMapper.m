//
//  LocationMapper.m
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import "LocationMapper.h"

@implementation LocationMapper
-(id) initWithPlacemarkDictionary:(NSDictionary *)description
{
    if(self = [super init])     // not required but for safe coding...
    {
        if(description[@"City"])_city = description[@"City"];
        if(description[@"State"])_state = description[@"State"];
        if(description[@"Country"])_country = description[@"Country"];
    }
    return self;
}

-(NSString *) getAddressStringWithDelimiter:(NSString *) delimiter
{
    NSMutableArray *addressArray = [NSMutableArray array];
    if(self.city.length > 0)
    {
        [addressArray addObject:self.city];
    }
    if(self.state.length > 0)
    {
        [addressArray addObject:self.state];
    }
    if(self.country.length > 0)
    {
        [addressArray addObject:self.country];
    }
    
    return [addressArray componentsJoinedByString:delimiter];
}


/*
 CLGeocoder returns Country for USA as a string "United States" which is not recognizable by OpenWeatherMap API
 Thus using this hack to not return country when city/state values are available.
 This could be resolved in many ways, this was the first thing that came to my mind.
 */
-(NSString *) getAddressStringForURL
{
    NSMutableArray *addressArray = [NSMutableArray array];
    if(self.city.length > 0)
    {
        [addressArray addObject:self.city];
    }
    if(self.state.length > 0)
    {
        [addressArray addObject:self.state];
    }
    if(self.country.length > 0 && self.city.length == 0 && self.state.length == 0)
    {
        [addressArray addObject:self.country];
    }
    
    return [addressArray componentsJoinedByString:@","];
}

@end
