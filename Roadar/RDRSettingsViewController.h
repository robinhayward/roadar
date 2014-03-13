//
//  RDRSettingsViewController.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRViewController.h"
#import "RDRSettingsView.h"

@class RDRBeaconStore, RDRUser, RDRMotion;

@interface RDRSettingsViewController : RDRViewController

@property (strong, nonatomic) RDRSettingsView *view;
@property (strong, nonatomic) RDRUser *user;
@property (strong, nonatomic) RDRBeaconStore *beaconStore;
@property (strong, nonatomic) RDRMotion *motion;

@end
