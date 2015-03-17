//
//  OpenWeatherMapAPI.m
//  AccuTest
//
//  Created by Varun Goyal on 3/15/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import "OpenWeatherMapAPI.h"
#import <AFNetworking/AFNetworking.h>
#define API_KEY @"2c64f099045c0b675da167c573ee6f4f"

@interface OpenWeatherMapAPI()
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) LocationMapper *location;
@end

@implementation OpenWeatherMapAPI
-(id) initWithLocation:(LocationMapper *) location

{
    if(self = [super init])
    {
        _baseURL = @"http://api.openweathermap.org/data/2.5/";
        _location = location;
    }
    return self;
}

-(void) getCurrentWeatherWithCompletionHandler:(CurrentWeatherCompletionHandler) completionHandler
{
    // To create string...
    NSString *urlString = [NSString stringWithFormat:@"%@weather?q=%@&APPID=%@", self.baseURL, [self.location getAddressStringForURL], API_KEY];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"cod"] integerValue] != 200)
        {
            completionHandler(nil, [responseObject objectForKey:@"message"]);
        }
        else
        {
            WeatherMapper *weatherMapper = [[WeatherMapper alloc] initWithJSON:responseObject];
            completionHandler(weatherMapper, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error description]);
        completionHandler(nil, [error localizedDescription]);
    }];
    
    
    [requestOperation start];
    
}


@end
