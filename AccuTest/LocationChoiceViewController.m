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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LocationChoiceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
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
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didSelectLocation:self.addresses[indexPath.row]];
    }];
}

- (IBAction)buttonCancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
