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

@property (strong, nonatomic) NSNumber *userIdentifier;

- (void)reset;
- (void)addBeacons:(NSArray *)beacons;
- (NSArray *)closestActiveBeacons;
- (NSArray *)closestActivePedestrianBeacons;
- (BOOL)beaconIdentifierIsInUse:(NSNumber *)identifer;
- (NSNumber *)nextAvailableIdentifier;

@end
