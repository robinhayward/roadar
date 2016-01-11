//
//  RDRUtilities.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "RDRConstants.h"

@interface RDRUtilities : NSObject

+ (NSString *)roleStringFromBeacon:(CLBeacon *)beacon;
+ (NSString *)stateStringFromBeacon:(CLBeacon *)beacon;
+ (NSInteger)beaconMinorForActivity:(CMMotionActivity *)activity;
+ (NSString *)stateStringFromActivity:(CMMotionActivity *)activity;
+ (NSString *)proximityStringFromBeacon:(CLBeacon *)beacon;
+ (NSString *)currentDateForDisplay;
+ (NSString *)roleStringFromRole:(RDRRole)role;
+ (NSString *)stateStringFromState:(RDRState)state;

+ (RDRRole)roleFromState:(RDRState)state;

@end

