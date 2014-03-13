//
//  RDRBeaconStore.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "RDRConstants.h"
#import "RDRBeaconReceipt.h"

@interface RDRBeaconStore : NSObject

- (void)addBeacons:(NSArray *)beacons;
- (RDRRole)lastKnownRoleForBeacon:(CLBeacon *)beacon;
- (RDRState)lastKnownStateForBeacon:(CLBeacon *)beacon;
- (NSArray *)closestActiveBeacons;

@end
