//
//  NSString+TemperatureConversion.h
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TemperatureConversion)

/**
 This method will convert the kelvin value of temperature into absolute integer Fahrenheit value.
 Note: should only be used on a temperature type object.
 */
- (NSString *)convertToAbsoluteFahrenheit;

/**
 This method will convert the kelvin value of temperature into absolute integer Celcius value.
 Note: should only be used on a temperature type object.
 */
- (NSString *)convertToAbsoluteCelcius;

@end