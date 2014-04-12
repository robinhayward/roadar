//
//  RDRBeacon.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRTransmitter.h"
#import "RDRBeacon.h"
#import "RDRConstants.h"

@interface RDRTransmitter () <CBPeripheralManagerDelegate>

@property (strong, nonatomic) NSUUID *UUID;
@property (strong, nonatomic) CMMotionActivityManager *activtyManager;
@property (strong, nonatomic) NSOperationQueue *activityManagerQueue;

@end

@implementation RDRTransmitter

- (instancetype)initWithUUID:(NSString *)UUIDString
{
  self = [super init];
  if (self) {
    self.major = @1;
    self.minor = @0;
    self.UUID = [[NSUUID alloc] initWithUUIDString:UUIDString];
  }
  return self;
}

- (void)startWithMajor:(NSInteger)major minor:(NSInteger)minor
{
  self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.UUID major:major minor:minor identifier:@"co.uk.mayker"];
  self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
  self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
  [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)stop
{
  [self.peripheralManager stopAdvertising];
  [UIApplication sharedApplication].idleTimerDisabled = NO;
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
  switch (peripheral.state) {
    case CBPeripheralManagerStatePoweredOff:
      NSLog(@"Bluetooth is off");
      break;
    default:
      [self.peripheralManager startAdvertising:self.beaconPeripheralData];
      break;
  }
}

@end
