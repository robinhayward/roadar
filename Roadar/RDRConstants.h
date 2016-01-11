//
//  RDRConstants.h
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RDRMode) {
  RDROfflineMode,
  RDRCyclistMode,
  RDRDriverMode
};

typedef NS_ENUM(NSInteger, RDRRole) {
  RDRUnknownRole,
  RDRCyclistRole,
  RDRDriverRole
};

typedef NS_ENUM(NSInteger, RDRState) {
  RDRUnknownState,
  RDRWalkingState,
  RDRRunningState,
  RDRAutomotiveState,
  RDRStationaryState
};

#define BEACON_UUID @"23542266-18D1-4FE4-B4A1-23F8195B9D39"

#define ACTIVITY_UNKNOWN -1
#define ACTIVITY_STATIONARY 0
#define ACTIVITY_PEDESTRIAN 1
#define ACTIVITY_CYCLIST 2
#define ACTIVITY_DRIVER 3