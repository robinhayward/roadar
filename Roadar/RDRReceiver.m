//
//  RDRReceiver.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRReceiver.h"

@interface RDRReceiver () <CLLocationManagerDelegate>

@end

@implementation RDRReceiver

- (instancetype)initWithUUID:(NSString *)UUIDString
{
  self = [super init];
  if (self) {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSUUID *UUID = [[NSUUID alloc] initWithUUIDString:UUIDString];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:UUID identifier:@"co.uk.mayker"];
    
  }
  return self;
}

- (void)start
{
  [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
  [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
  [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
  [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
  if ([beacons count] > 0) {
    self.receivedBeaconsblock(beacons);
  }
}
@end
