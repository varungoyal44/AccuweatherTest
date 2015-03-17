//
//  NSString+TemperatureConversion.h
//  AccuTest
//
//  Created by Varun Goyal on 3/16/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TemperatureConversion)

- (NSString *)convertToAbsoluteFahrenheit;
- (NSString *)convertToAbsoluteCelcius;

@end