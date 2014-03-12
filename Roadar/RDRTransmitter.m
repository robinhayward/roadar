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
    self.major = @0;
    self.minor = @0;
    self.UUID = [[NSUUID alloc] initWithUUIDString:UUIDString];
  }
  return self;
}

#pragma mark - CBPeripheralManagerDelegate

- (void)transmit
{
  __weak typeof(self) weakSelf = self;
  self.activityManagerQueue = [[NSOperationQueue alloc] init];
  self.activtyManager = [[CMMotionActivityManager alloc] init];
  [self.activtyManager startActivityUpdatesToQueue:self.activityManagerQueue withHandler:^(CMMotionActivity *activity) {
    
    NSInteger minor = [RDRBeacon beaconMinorForActivity:activity];
    if (minor == ACTIVITY_UNKNOWN) {
      [self.peripheralManager stopAdvertising];
    } else {
      weakSelf.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:weakSelf.UUID major:weakSelf.major.integerValue minor:minor identifier:@"co.uk.mayker"];
      weakSelf.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
      weakSelf.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:weakSelf queue:nil options:nil];
    }
  }];

}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
  if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
    NSLog(@"Powered On");
    [self.peripheralManager startAdvertising:self.beaconPeripheralData];
  } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
    NSLog(@"Powered Off");
    [self.peripheralManager stopAdvertising];
  }
}

@end
