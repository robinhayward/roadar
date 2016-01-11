//
//  RDRBeacon.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRBeacon.h"
#import "RDRConstants.h"

@implementation RDRBeacon

+ (NSString *)roleFromBeacon:(CLBeacon *)beacon
{
  NSUInteger minor = beacon.minor.unsignedIntegerValue;
  switch (minor) {
    case ACTIVITY_PEDESTRIAN:
      return NSLocalizedString(@"Pedestrian", nil);
      break;
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
  if (activity.unknown) return ACTIVITY_UNKNOWN;
  return ACTIVITY_UNKNOWN;
}

@end
