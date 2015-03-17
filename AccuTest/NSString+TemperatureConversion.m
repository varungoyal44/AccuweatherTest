//
//  NSString+TemperatureConversion.m
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import "NSString+TemperatureConversion.h"

@implementation NSString (TemperatureConversion)

- (NSString *)convertToAbsoluteFahrenheit
{
    return [NSString stringWithFormat:@"%i", (int)((([self floatValue] - 273.15) * 1.8) + 32)];
}

- (NSString *)convertToAbsoluteCelcius
{
    return [NSString stringWithFormat:@"%i", (int)([self floatValue] - 273.15)];
}

@end
