//
//  RDRMotion.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRMotion.h"

@implementation RDRMotion

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.activityManager = [[CMMotionActivityManager alloc] init];
    [self.activityManager startActivityUpdatesToQueue:self.operationQueue withHandler:^(CMMotionActivity *activity) {
      
      if (activity.unknown) {
        self.state = RDRUnknownState;
      } else if (activity.stationary) {
        self.state = RDRStationaryState;
      } else if (activity.walking) {
        self.state = RDRWalkingState;
      } else if (activity.running) {
        self.state = RDRRunningState;
      } else if (activity.automotive) {
        self.state = RDRAutomotiveState;
      }
      
      self.activity = activity;
      if (self.activityUpdateBlock) self.activityUpdateBlock(self.activity, self.state);
    }];
  }
  return self;
}

@end
