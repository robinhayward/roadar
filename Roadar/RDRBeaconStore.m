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
@property (strong, nonatomic) NSMutableIndexSet *identifiers;

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

- (void)reset
{
  self.store = [[NSMutableDictionary alloc] init];
}

- (void)addBeacons:(NSArray *)beacons
{
  for (CLBeacon *beacon in beacons) {
    
    NSNumber *identifier = beacon.major;
    RDRBeaconReceipt *receipt = [self.store objectForKey:identifier];    
    if (!receipt) {
      receipt = [[RDRBeaconReceipt alloc] init];
      [self.store setObject:receipt forKey:identifier];
    }
    [self prepareReceipt:receipt forBeacon:beacon];
  }
  
  [self clearOldBeacons];
}

- (BOOL)beaconIdentifierIsInUse:(NSNumber *)identifer
{
  for (RDRBeaconReceipt *receipt in [self.store allValues]) {
    NSInteger taken = receipt.beacon.major.integerValue;
    NSInteger query = identifer.integerValue;
    if (taken == query) {
      return YES;
    }
  }
  return NO;
}

- (NSNumber *)nextAvailableIdentifier
{
  NSInteger highestIdentifierAllowed = 55000;
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"updated" ascending:NO];
  NSSortDescriptor *identifier = [NSSortDescriptor sortDescriptorWithKey:@"beacon.major" ascending:YES];
  NSArray *sorted = [[self.store allValues] sortedArrayUsingDescriptors:@[dateSort, identifier]];
  if ([sorted count] == 0) return @1;
  RDRBeaconReceipt *receipt = [sorted objectAtIndex:0];
  NSInteger currentHighestIdentifier = [receipt.beacon.major integerValue];
  if (currentHighestIdentifier < highestIdentifierAllowed) {
    return [NSNumber numberWithInteger:(currentHighestIdentifier + 1)];
  }
  return nil;
}

- (void)clearOldBeacons
{
  NSMutableDictionary *storeCopy = [self.store mutableCopy];
  for (RDRBeaconReceipt *receipt in [storeCopy allValues]) {
    if (receipt.isExpired) {
      [self.store removeObjectForKey:receipt.userIdentifier];
    }
  }
}

- (NSArray *)closestActiveBeacons
{
  NSArray *receipts = [self.store allValues];
  NSPredicate *active = [NSPredicate predicateWithFormat:@"beacon.proximity != %d", CLProximityUnknown];
  NSPredicate *knownState = [NSPredicate predicateWithFormat:@"role != %d", RDRUnknownState];
  NSPredicate *identifier = [NSPredicate predicateWithFormat:@"userIdentifier != %@", self.userIdentifier];
  NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[active, identifier, knownState]];
  NSArray *filtered = [receipts filteredArrayUsingPredicate:predicate];
  if ([filtered count] == 0) return nil;
  
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"updated" ascending:NO];
  NSSortDescriptor *proximity = [NSSortDescriptor sortDescriptorWithKey:@"beacon.proximity" ascending:YES];
  NSArray *sorted = [filtered sortedArrayUsingDescriptors:@[dateSort, proximity]];
  return sorted;
}

- (NSArray *)closestActivePedestrianBeacons
{
  NSArray *receipts = [self.store allValues];
  NSPredicate *active = [NSPredicate predicateWithFormat:@"beacon.proximity != %d", CLProximityUnknown];
  NSPredicate *knownState = [NSPredicate predicateWithFormat:@"role != %d", RDRUnknownState];
  NSPredicate *pedestrian = [NSPredicate predicateWithFormat:@"role != %d", RDRDriverRole];
  NSPredicate *identifier = [NSPredicate predicateWithFormat:@"userIdentifier != %@", self.userIdentifier];
  NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[active, pedestrian, identifier, knownState]];
  NSArray *filtered = [receipts filteredArrayUsingPredicate:predicate];
  if ([filtered count] == 0) return nil;
  
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"updated" ascending:NO];
  NSSortDescriptor *proximity = [NSSortDescriptor sortDescriptorWithKey:@"beacon.proximity" ascending:YES];
  NSArray *sorted = [filtered sortedArrayUsingDescriptors:@[dateSort, proximity]];
  return sorted;
}

- (NSArray *)closestActiveDriverBeacons
{
  NSArray *receipts = [self.store allValues];
  NSPredicate *active = [NSPredicate predicateWithFormat:@"beacon.proximity != %d", CLProximityUnknown];
  NSPredicate *driver = [NSPredicate predicateWithFormat:@"role == %d", RDRDriverRole];
  NSPredicate *identifier = [NSPredicate predicateWithFormat:@"userIdentifier != %@", self.userIdentifier];
  NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[active, driver, identifier]];
  NSArray *filtered = [receipts filteredArrayUsingPredicate:predicate];
  if ([filtered count] == 0) return nil;
  
  NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"updated" ascending:NO];
  NSSortDescriptor *proximity = [NSSortDescriptor sortDescriptorWithKey:@"beacon.proximity" ascending:YES];
  NSArray *sorted = [filtered sortedArrayUsingDescriptors:@[dateSort, proximity]];
  return sorted;
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

#pragma mark - Private

- (void)prepareReceipt:(RDRBeaconReceipt *)receipt forBeacon:(CLBeacon *)beacon
{
  receipt.updated = [NSDate date];
  receipt.beacon = beacon;
  receipt.userIdentifier = beacon.major;
  receipt.state = [beacon.minor integerValue];
  RDRRole role = [RDRUtilities roleFromState:[beacon.minor integerValue]];
  if (role != RDRUnknownRole) {
    receipt.role = role;
  }
}

@end
