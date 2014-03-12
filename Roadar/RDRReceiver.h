//
//  RDRReceiver.h
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef void(^RDRReceivedBeacons)(NSArray *beacons);

@interface RDRReceiver : NSObject

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (readwrite, copy) RDRReceivedBeacons receivedBeaconsblock;

- (id)initWithUUID:(NSString *)UUID;

- (void)start;

@end
