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
#import "RDRSettingsViewController.h"

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
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
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
  [self.view.modeButton addTarget:self action:@selector(leftBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
  [self presentModeForUser];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  __weak typeof(self) weakSelf = self;
  
  weakSelf.beaconStore.userIdentifier = weakSelf.user.beaconIdentifier;
  self.motion.activityUpdateBlock = ^(CMMotionActivity *activity, RDRState state) {
    
    // TODO.. Rate limit this to once a second
    // TODO.. Validate activity for mode (eg. If set as pedestrian or cyclist but driving detected.. raise it)
    
    weakSelf.view.userStateLabel.text = [RDRUtilities stateStringFromActivity:activity];
    if ((weakSelf.user.mode == RDRPedestrianMode) || (weakSelf.user.mode == RDRCyclistMode)) {
      [weakSelf startTransmittingWithState:state];
    }

  };
  
  self.receiver.receivedBeaconsblock = ^(NSArray *beacons) {
  
    [weakSelf.beaconStore addBeacons:beacons];
   
    
    if ((weakSelf.user.mode == RDRPedestrianMode) || (weakSelf.user.mode == RDRCyclistMode)) {
      
      if ([weakSelf.beaconStore beaconIdentifierIsInUse:weakSelf.user.beaconIdentifier]) {
        weakSelf.user.beaconIdentifier = [weakSelf.beaconStore nextAvailableIdentifier];
        weakSelf.beaconStore.userIdentifier = weakSelf.user.beaconIdentifier;
      }
      NSArray *activeBeaconReceipts = [weakSelf.beaconStore closestActiveBeacons];
      weakSelf.view.countLabel.text = [NSString stringWithFormat:@"%ld", (long)[activeBeaconReceipts count]];
    }
    else if (weakSelf.user.mode == RDRDriverMode) {
      NSArray *activeBeaconReceipts = [weakSelf.beaconStore closestActivePedestrianBeacons];
      weakSelf.view.countLabel.text = [NSString stringWithFormat:@"%ld", (long)[activeBeaconReceipts count]];
      if (activeBeaconReceipts) {
        [weakSelf presentInferfaceStateDriverWithWarnings:activeBeaconReceipts];
      } else {
        [weakSelf presentInterfaceStateDriverAllClear];
      }
    }
  
  };
}

- (void)startTransmittingWithState:(RDRState)state
{
  if (self.user.beaconIdentifier) {
    [self.beacon startWithMajor:self.user.beaconIdentifier.integerValue minor:state];
  } else {
    NSLog(@"Error: No available identifiers for transmit");
  }
}

#pragma mark - Interface State

- (void)presentInterfaceStateDriver
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.noticeLabel.text = nil;
  self.view.countLabel.text = @"0";
  self.view.proximityLabel.text = nil;
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
  self.view.riskView.backgroundColor = [UIColor clearColor];
  [self.view.modeButton setTitle:NSLocalizedString(@"Driver", nil) forState:UIControlStateNormal];
}

- (void)presentInterfaceStateDriverAllClear
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.noticeLabel.text = NSLocalizedString(@"All Clear", nil);
  self.view.countLabel.text = @"0";
  self.view.proximityLabel.text = nil;
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
  self.view.riskView.backgroundColor = [UIColor greenColor];
  [self.view.modeButton setTitle:NSLocalizedString(@"Driver", nil) forState:UIControlStateNormal];
}

- (void)presentInferfaceStateDriverWithWarnings:(NSArray *)warnings
{
  RDRBeaconReceipt *receipt = [warnings objectAtIndex:0];
  
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.proximityLabel.text = [RDRUtilities proximityStringFromBeacon:receipt.beacon];
  self.view.proximityTimeLabel.text = [RDRUtilities currentDateForDisplay];
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = [RDRUtilities stateStringFromState:receipt.state];
  switch (receipt.beacon.proximity) {
    case CLProximityFar:
      self.view.riskView.backgroundColor = [UIColor orangeColor];
      self.view.noticeLabel.text = NSLocalizedString(@"Pedestrians", nil);
      break;
    case CLProximityNear:
      self.view.riskView.backgroundColor = [UIColor redColor];
      self.view.noticeLabel.text = NSLocalizedString(@"Pedestrians Alert", nil);
      break;
    case CLProximityImmediate:
      self.view.riskView.backgroundColor = [UIColor redColor];
      self.view.noticeLabel.text = NSLocalizedString(@"Pedestrians Alert", nil);
      break;
    default:
      self.view.riskView.backgroundColor = [UIColor clearColor];
      break;
  }
  [self.view.modeButton setTitle:NSLocalizedString(@"Driver", nil) forState:UIControlStateNormal];
}

- (void)presentInferfaceStatePedestrian
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.noticeLabel.text = NSLocalizedString(@"Broadcasting Presence", nil);
  self.view.countLabel.text = @"0";
  self.view.proximityLabel.text = nil;
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
  self.view.riskView.backgroundColor = [UIColor greenColor];
  [self.view.modeButton setTitle:NSLocalizedString(@"Pedestrian", nil) forState:UIControlStateNormal];
}

- (void)presentInferfaceStateCyclist
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.noticeLabel.text = NSLocalizedString(@"Broadcasting Presence", nil);
  self.view.countLabel.text = @"0";
  self.view.proximityLabel.text = nil;
  self.view.proximityUserLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
  self.view.riskView.backgroundColor = [UIColor greenColor];
  [self.view.modeButton setTitle:NSLocalizedString(@"Cyclist", nil) forState:UIControlStateNormal];
}

- (void)presentInferfaceStateOffline
{
  self.view.userLabel.text = [self.user.beaconIdentifier stringValue];
  self.view.noticeLabel.text = NSLocalizedString(@"Offline", nil);
  self.view.countLabel.text = @"0";
  self.view.userRoleLabel.text = nil;
  self.view.proximityLabel.text = nil;
  self.view.proximityTimeLabel.text = nil;
  self.view.proximityRoleLabel.text = nil;
  self.view.proximityStateLabel.text = nil;
  self.view.riskView.backgroundColor = [UIColor blueColor];
  [self.view.modeButton setTitle:NSLocalizedString(@"Offline", nil) forState:UIControlStateNormal];
}

#pragma mark - Actions

- (void)leftBarButtonAction
{
  [UIView animateWithDuration:.3 animations:^{
    self.view.modeButton.alpha = 0;
  }];
  self.modeActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Mode" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pedestrian", @"Cyclist", @"Driver", @"Go Offline", nil];
  [self.modeActionSheet showInView:self.view];
}

- (void)rightBarButtonAction
{
  RDRSettingsViewController *viewController = [[RDRSettingsViewController alloc] initWithNibName:nil bundle:nil];
  viewController.user = self.user;
  viewController.motion = self.motion;
  viewController.beaconStore = self.beaconStore;
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)offlineMode
{
  self.user.mode = RDROfflineMode;
  [self.beacon stop];
  [self.receiver stop];
  [self.beaconStore reset];
  [self presentInferfaceStateOffline];
}

- (void)pedestrianMode
{
  self.user.mode = RDRPedestrianMode;
  [self.beacon stop];
  [self.receiver stop];
  [self.beaconStore reset];
  [self.receiver start];
  [self startTransmittingWithState:RDRUnknownState];
  [self presentInferfaceStatePedestrian];
}

- (void)cyclingMode
{
  self.user.mode = RDRCyclistMode;
  [self.beacon stop];
  [self.receiver stop];
  [self.beaconStore reset];
  [self.receiver start];
  [self startTransmittingWithState:RDRUnknownState];
  [self presentInferfaceStateCyclist];
}

- (void)drivingMode
{
  self.user.mode = RDRDriverMode;
  [self.beacon stop];
  [self.receiver stop];
  [self.beaconStore reset];
  [self.receiver start];
  [self startTransmittingWithState:RDRAutomotiveState];
  [self presentInterfaceStateDriverAllClear];
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
      break;
    default:
      break;
  }
  [UIView animateWithDuration:.6 animations:^{
    self.view.modeButton.alpha = 1;
  }];
}

@end
