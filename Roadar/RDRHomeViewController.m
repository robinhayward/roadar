//
//  RDRHomeViewController.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRHomeViewController.h"
#import "RDRHomeView.h"
#import "RDRTransmitter.h"
#import "RDRReceiver.h"
#import "RDRBeacon.h"

@interface RDRHomeViewController ()

@end

@implementation RDRHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Roadar", nil);
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Transmit", nil) style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Listen", nil) style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
  }
  return self;
}

- (void)loadView
{
  self.view = [[RDRHomeView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  __weak typeof(self) weakSelf = self;
  self.receiver.receivedBeaconsblock = ^(NSArray *beacons){
  
    CLBeacon *beacon = [beacons lastObject];
    if (!beacon) return;
    
    NSString *proximityString = NSLocalizedString(@"Unknown Proximity", nil);
    if (beacon.proximity == CLProximityImmediate) {
      proximityString = NSLocalizedString(@"Immediate", nil);
    } else if (beacon.proximity == CLProximityNear) {
      proximityString = NSLocalizedString(@"Near", nil);
    } else if (beacon.proximity == CLProximityFar) {
      proximityString= NSLocalizedString(@"Far", nil);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d/m/yyyy hh:mm:ss";
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    weakSelf.view.timeLabel.text = dateString;
    weakSelf.view.roleLabel.text = [RDRBeacon roleFromBeacon:beacon];
    weakSelf.view.proximityLabel.text = proximityString;
  };
}

#pragma mark - Actions

- (void)leftBarButtonAction:(id)sender
{
  [self.beacon transmit];
}

- (void)rightBarButtonAction:(id)sender
{
  [self.receiver start];
}

@end
