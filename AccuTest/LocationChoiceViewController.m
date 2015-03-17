//
//  LocationChoiceViewController.m
//  AccuTest
//
//  Created by Varun Goyal on 3/15/15.
//  Copyright (c) 2015 Accuweather. All rights reserved.
//

#import "LocationChoiceViewController.h"
#import "LocationMapper.h"

@interface LocationChoiceViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LocationChoiceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addresses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    LocationMapper *location = self.addresses[indexPath.row];
    [cell.textLabel setText:[location getAddressStringWithDelimiter:@", "]];
    return cell;
}

- (IBAction)buttonCancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
