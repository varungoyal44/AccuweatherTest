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

-(id) initWithPlacemarkDictionary:(NSDictionary *)description;
-(NSString *) getAddressStringWithDelimiter:(NSString *) delimiter;
-(NSString *) getAddressStringForURL;
@end
