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
#import "RDRUser.h"

@interface RDRHomeViewController () <UIActionSheetDelegate>

@property (assign, nonatomic) BOOL transmit;
@property (strong, nonatomic) RDRBeaconStore *beaconStore;
@property (strong, nonatomic) UIActionSheet *modeActionSheet;

@end

@implementation RDRHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Roadar", nil);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Mode", nil) style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.beaconStore = [[RDRBeaconStore alloc] init];
  }
  return self;
}

- (void)loadView
{
  self.view = [[RDRHomeView alloc] init];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self presentModeForUser];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  __weak typeof(self) weakSelf = self;
  
  self.motion.activityUpdateBlock = ^(CMMotionActivity *activity, RDRState state) {
    
    // TODO.. Rate limit this to once a second
    
    RDRRole role = [RDRUtilities roleFromState:state];
    weakSelf.view.userRoleLabel.text = [RDRUtilities roleStringFromRole:role];
    weakSelf.view.userStateLabel.text = [RDRUtilities stateStringFromActivity:activity];
    if ((weakSelf.user.mode == RDRPedestrianMode) || (weakSelf.user.mode == RDRCyclistMode)) {
      
      if (weakSelf.user.beaconIdentifier) {
        [weakSelf.beacon startWithMajor:weakSelf.user.beaconIdentifier.integerValue minor:state];
      } else {
        NSLog(@"Error: No available identifiers for transmit");
      }
      
    }

  };
  
  self.receiver.receivedBeaconsblock = ^(NSArray *beacons) {
  
    [weakSelf.beaconStore addBeacons:beacons];
    NSArray *activeBeaconReceipts = [weakSelf.beaconStore closestActiveBeacons];
    
    if ((weakSelf.user.mode == RDRPedestrianMode) || (weakSelf.user.mode == RDRCyclistMode)) {
      
      if ([weakSelf.beaconStore beaconIdentifierIsInUse:weakSelf.user.beaconIdentifier]) {
        weakSelf.user.beaconIdentifier = [weakSelf.beaconStore nextAvailableIdentifier];
        weakSelf.view.userLabel.text = [weakSelf.user.beaconIdentifier stringValue];
      }
    }
    else if (weakSelf.user.mode == RDRDriverMode) {
      if (activeBeaconReceipts) {
        [weakSelf presentInferfaceStateDriverWithWarnings:activeBeaconReceipts];
      } else {
        [weakSelf presentInterfaceStateDriverAllClear];
      }
    }
  
  };
}

#pragma mark - Interface State

- (void)presentInterfaceStateDriverAllClear
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.userModeLabel.text = NSLocalizedString(@"Driver", nil);
  self.view.proximityLabel.text = NSLocalizedString(@"All Clear", nil);
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
}

- (void)presentInferfaceStateDriverWithWarnings:(NSArray *)warnings
{
  RDRBeaconReceipt *receipt = [warnings objectAtIndex:0];
  
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.userModeLabel.text = NSLocalizedString(@"Driver", nil);
  self.view.proximityLabel.text = [RDRUtilities proximityStringFromBeacon:receipt.beacon];
  self.view.proximityUserLabel.text = [receipt.userIdentifier stringValue];
  self.view.proximityTimeLabel.text = [RDRUtilities currentDateForDisplay];
  self.view.proximityRoleLabel.text = [RDRUtilities roleStringFromRole:receipt.role];
  self.view.proximityStateLabel.text = [RDRUtilities stateStringFromState:receipt.state];
}

- (void)presentInferfaceStatePedestrian
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.userModeLabel.text = NSLocalizedString(@"Pedestrian", nil);
  self.view.proximityLabel.text = NSLocalizedString(@"Your presence is being broadcast", nil);
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
}

- (void)presentInferfaceStateCyclist
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.userModeLabel.text = NSLocalizedString(@"Cyclist", nil);
  self.view.proximityLabel.text = NSLocalizedString(@"Your presence is being broadcast", nil);
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
}

- (void)presentInferfaceStateOffline
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.userModeLabel.text = NSLocalizedString(@"Offline", nil);
  self.view.userRoleLabel.text = nil;
  self.view.proximityLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
}

#pragma mark - Actions

- (void)rightBarButtonAction
{
  self.modeActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Mode" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pedestrian", @"Cyclist", @"Driver", @"Go Offline", nil];
  [self.modeActionSheet showInView:self.view];
}

- (void)offlineMode
{
  self.user.mode = RDROfflineMode;
  self.transmit = NO;
  [self.beacon stop];
  [self.receiver stop];
  [self presentInferfaceStateOffline];
}

- (void)pedestrianMode
{
  self.user.mode = RDRPedestrianMode;
  self.transmit = YES;
  [self.receiver start];
  [self presentInferfaceStatePedestrian];
}

- (void)cyclingMode
{
  self.user.mode = RDRCyclistMode;
  [self.receiver start];
  [self presentInferfaceStateCyclist];
}

- (void)drivingMode
{
  self.user.mode = RDRDriverMode;
  self.transmit = NO;
  [self.beacon stop];
  [self.receiver start];
  [self presentInferfaceStateDriverWithWarnings:nil];
}

- (void)presentModeForUser
{
  switch (self.user.mode) {
    case RDRPedestrianMode:
      [self pedestrianMode];
      break;
    case RDRCyclistMode:
      [self cyclingMode];
      break;
    case RDRDriverMode:
      [self drivingMode];
      break;
    default:
      [self offlineMode];
      break;
  }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  switch (buttonIndex) {
    case 0:
      [self pedestrianMode];
      break;
    case 1:
      [self cyclingMode];
      break;
    case 2:
      [self drivingMode];
      break;
    case 3:
      [self offlineMode];
    default:
      break;
  }
}

@end
