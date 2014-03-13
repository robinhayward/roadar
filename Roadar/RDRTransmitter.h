//
//  RDRBeacon.h
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreMotion/CoreMotion.h>
#import "RDRConstants.h"

@interface RDRTransmitter : NSObject

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) NSNumber *major;
@property (strong, nonatomic) NSNumber *minor;

- (id)initWithUUID:(NSString *)UUID;

- (void)startWithMajor:(NSInteger)major minor:(NSInteger)minor;

- (void)stop;

@end
