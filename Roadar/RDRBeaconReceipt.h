//
//  RDRBeaconReceipt.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "RDRConstants.h"

@interface RDRBeaconReceipt : NSObject

@property (strong, nonatomic) CLBeacon *beacon;
@property (strong, nonatomic) NSNumber *userIdentifier;
@property (strong, nonatomic) NSDate *updated;
@property (assign, nonatomic) RDRState state;
@property (assign, nonatomic) RDRRole role;

@end
