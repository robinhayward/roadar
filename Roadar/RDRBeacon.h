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

@interface RDRBeacon : NSObject

+ (NSString *)roleFromBeacon:(CLBeacon *)beacon;
+ (NSInteger)beaconMinorForActivity:(CMMotionActivity *)activity;

@end
