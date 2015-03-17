//
//  LocationChoiceViewController.h
//  AccuTest
//
//  Created by Varun Goyal on 3/15/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationMapper.h"
@protocol LocationChoiceProtocol;

@interface LocationChoiceViewController : UIViewController
@property (nonatomic, weak) NSArray *addresses;
@property (nonatomic, weak) id<LocationChoiceProtocol> delegate;
@end


@protocol LocationChoiceProtocol <NSObject>
-(void) didSelectLocation:(LocationMapper *) location;
@end