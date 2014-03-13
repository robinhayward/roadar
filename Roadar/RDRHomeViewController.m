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
#import "RDRMotion.h"
#import "RDRUtilities.h"
#import "RDRBeaconStore.h"

@interface RDRHomeViewController ()

@property (assign, nonatomic) BOOL transmit;
@property (strong, nonatomic) RDRBeaconStore *beaconStore;

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
    self.beaconStore = [[RDRBeaconStore alloc] init];
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
  
  self.motion.activityUpdateBlock = ^(CMMotionActivity *activity, RDRState state) {
    
    RDRRole role = [RDRUtilities roleFromState:state];
    weakSelf.view.userRoleLabel.text = [RDRUtilities roleStringFromRole:role];
    weakSelf.view.userStateLabel.text = [RDRUtilities stateStringFromActivity:activity];
    if (weakSelf.transmit) {
      [weakSelf.beacon startWithState:state];
    }
  };
  
  self.receiver.receivedBeaconsblock = ^(NSArray *beacons) {
  
    [weakSelf.beaconStore addBeacons:beacons];
    RDRBeaconReceipt *receipt = [weakSelf.beaconStore closestKnownBeacon];
    if (receipt) {
      weakSelf.view.proximityLabel.text = [RDRUtilities proximityStringFromBeacon:receipt.beacon];
      weakSelf.view.proximityTimeLabel.text = [RDRUtilities currentDateForDisplay];
      weakSelf.view.proximityRoleLabel.text = [RDRUtilities roleStringFromRole:receipt.role];
      weakSelf.view.proximityStateLabel.text = [RDRUtilities stateStringFromState:receipt.state];
    }
  };
}

#pragma mark - Actions

- (void)leftBarButtonAction:(id)sender
{
  if (self.transmit) {
    self.transmit = NO;
  } else {
    self.transmit = YES;
  }
}

- (void)rightBarButtonAction:(id)sender
{
  [self.receiver start];
}

@end
