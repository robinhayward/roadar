//
//  RDRBeaconReceipt.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRBeaconReceipt.h"

@implementation RDRBeaconReceipt

- (BOOL)isExpired
{
  NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.updated];
  if (interval > 30) {
    return YES;
  }
  return NO;
}

@end
