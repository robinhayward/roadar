//
//  RDRBeaconStore.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRBeaconStore.h"
#import "RDRBeaconReceipt.h"
#import "RDRUtilities.h"

@interface RDRBeaconStore ()

@property (strong, nonatomic) NSMutableDictionary *store;

@end

@implementation RDRBeaconStore

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.store = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)addBeacons:(NSArray *)beacons
{
  for (CLBeacon *beacon in beacons) {
    NSNumber *userIdentifier = beacon.major;
    NSNumber *state = beacon.minor;
    
    RDRBeaconReceipt *receipt = [self.store objectForKey:userIdentifier];
    if (!receipt) {
      receipt = [[RDRBeaconReceipt alloc] init];
      [self.store setObject:receipt forKey:userIdentifier];
    }
    
    receipt.updated = [NSDate date];
    receipt.beacon = beacon;
    receipt.userIdentifier = beacon.major;
    receipt.state = [beacon.minor integerValue];
    RDRRole role = [RDRUtilities roleFromState:[state integerValue]];
    if (role != RDRUnknownRole) {
      receipt.role = role;
    }
  }
}

- (RDRBeaconReceipt *)closestKnownBeacon
{
  NSArray *receipts = [self.store allValues];
  if ([receipts count] == 0) return nil;
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"updated" ascending:NO];
  NSArray *sorted = [receipts sortedArrayUsingDescriptors:@[dateSort]];
  return [sorted objectAtIndex:0];
}

- (RDRRole)lastKnownRoleForBeacon:(CLBeacon *)beacon
{
  RDRBeaconReceipt *receipt = [self.store objectForKey:beacon.major];
  if (receipt) {
    return receipt.role;
  }
  return RDRUnknownRole;
}

- (RDRState)lastKnownStateForBeacon:(CLBeacon *)beacon
{
  RDRBeaconReceipt *receipt = [self.store objectForKey:beacon.major];
  if (receipt) {
    return receipt.state;
  }
  return RDRUnknownState;
}

@end
