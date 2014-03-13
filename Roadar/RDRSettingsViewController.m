//
//  RDRSettingsViewController.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRSettingsViewController.h"
#import "RDRSettingsView.h"
#import "RDRUtilities.h"
#import "RDRBeaconStore.h"
#import "RDRUser.h"
#import "RDRMotion.h"

@interface RDRSettingsViewController ()

@end

@implementation RDRSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Settings", nil);
  }
  return self;
}

- (void)loadView
{
  self.view = [[RDRSettingsView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.view.beaconIdentifierLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Current Identifier:", nil), self.user.beaconIdentifier];
  NSArray *receipts = [self.beaconStore closestActiveBeacons];
  NSString *closestBeaconString = NSLocalizedString(@"No other beacons in range", nil);
  if (receipts) {
    RDRBeaconReceipt *receipt = [receipts objectAtIndex:0];
    closestBeaconString = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Closest Beacon Identifier:", nil), [receipt.beacon.major stringValue]];
  }
  self.view.closestBeaconIdentifierLabel.text = closestBeaconString;
  
  NSString *motionString = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Your activity: ", nil), [RDRUtilities stateStringFromState:self.motion.state]];
  self.view.motionActivityLabel.text = motionString;
}

@end
