//
//  LocationMapper.h
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationMapper : NSObject
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;

/**
 To initialize an object of LocationMapper.
 @param description is the placemark description returned by CLGeocoder when the address lookup is initiated.
 */
-(id) initWithPlacemarkDictionary:(NSDictionary *)description;

/**
 To get a single line address of the location.
 @param delimiter will be added between various subsets of address.
 */
-(NSString *) getAddressStringWithDelimiter:(NSString *) delimiter;

/**
 To get the address string which can be used by OpenWeatherMap API for its URL creation.
 */
-(NSString *) getAddressStringForURL;
@end
