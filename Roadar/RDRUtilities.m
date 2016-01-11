//
//  RDRUtilities.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRUtilities.h"
#import "RDRConstants.h"

@implementation RDRUtilities

+ (NSString *)roleStringFromBeacon:(CLBeacon *)beacon
{
  NSInteger minor = beacon.minor.integerValue;
  switch (minor) {
    case ACTIVITY_CYCLIST:
      return NSLocalizedString(@"Cyclist", nil);
      break;
    case ACTIVITY_DRIVER:
      return NSLocalizedString(@"Driver", nil);
      break;
    case ACTIVITY_STATIONARY:
      return NSLocalizedString(@"Staionary", nil);
      break;
    default:
      return NSLocalizedString(@"Unknown Role", nil);
      break;
  }
}

+ (NSString *)stateStringFromBeacon:(CLBeacon *)beacon
{
  NSInteger minor = beacon.minor.integerValue;
  switch (minor) {
    case ACTIVITY_CYCLIST:
      return NSLocalizedString(@"Cyclist", nil);
      break;
    case ACTIVITY_DRIVER:
      return NSLocalizedString(@"Driver", nil);
      break;
    case ACTIVITY_STATIONARY:
      return NSLocalizedString(@"Staionary", nil);
      break;
    default:
      return NSLocalizedString(@"Unknown Role", nil);
      break;
  }
}

+ (NSInteger)beaconMinorForActivity:(CMMotionActivity *)activity
{
  if (activity.stationary) return ACTIVITY_STATIONARY;
  if (activity.walking) return ACTIVITY_PEDESTRIAN;
  if (activity.running) return ACTIVITY_CYCLIST;
  if (activity.automotive) return ACTIVITY_DRIVER;
  return ACTIVITY_UNKNOWN;
}

+ (NSString *)stateStringFromActivity:(CMMotionActivity *)activity
{
  if (activity.stationary) return NSLocalizedString(@"Stationary", nil);
  if (activity.walking) return NSLocalizedString(@"Walking", nil);
  if (activity.running) return NSLocalizedString(@"Running", nil);
  if (activity.automotive) return NSLocalizedString(@"Automotive", nil);
  return NSLocalizedString(@"Unknown", nil);
}

+ (NSString *)proximityStringFromBeacon:(CLBeacon *)beacon
{
  NSString *proximityString = NSLocalizedString(@"Unknown Proximity", nil);
  if (beacon.proximity == CLProximityImmediate) {
    proximityString = NSLocalizedString(@"Immediate", nil);
  } else if (beacon.proximity == CLProximityNear) {
    proximityString = NSLocalizedString(@"Near", nil);
  } else if (beacon.proximity == CLProximityFar) {
    proximityString = NSLocalizedString(@"Far", nil);
  }
  return proximityString;
}

+ (NSString *)currentDateForDisplay
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"d/M/yyyy HH:mm:ss";
  return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)roleStringFromRole:(RDRRole)role
{
  switch (role) {
    case RDRCyclistRole:
      return NSLocalizedString(@"Cyclist", nil);
      break;
    case RDRDriverRole:
      return NSLocalizedString(@"Driver", nil);
      break;
    default:
      return NSLocalizedString(@"Role Unknown", nil);
      break;
  }
}

+ (NSString *)stateStringFromState:(RDRState)state
{
  switch (state) {
    case RDRStationaryState:
      return NSLocalizedString(@"Stationary", nil);
      break;
    case RDRWalkingState:
      return NSLocalizedString(@"Walking", nil);;
      break;
    case RDRRunningState:
      return NSLocalizedString(@"Running", nil);;
      break;
    case RDRAutomotiveState:
      return NSLocalizedString(@"Automotive", nil);;
      break;
    default:
      return NSLocalizedString(@"Unknown", nil);;
      break;
  }
}

+ (RDRRole)roleFromState:(RDRState)state
{
  switch (state) {
    case RDRStationaryState:
      return RDRUnknownRole;
      break;
    case RDRWalkingState:
      return RDRCyclistRole;
      break;
    case RDRRunningState:
      return RDRCyclistRole;
      break;
    case RDRAutomotiveState:
      return RDRDriverRole;
      break;
    default:
      return RDRUnknownRole;
      break;
  }
}

@end
