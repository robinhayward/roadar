//
//  RDRMotion.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "RDRConstants.h"

typedef void(^RDRMotionActivityUpdate)(CMMotionActivity *activity, RDRState state);

@interface RDRMotion : NSObject

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) CMMotionActivityManager *activityManager;
@property (strong, nonatomic) CMMotionActivity *activity;
@property (assign, nonatomic) RDRRole role;
@property (assign, nonatomic) RDRState state;
@property (readwrite, copy) RDRMotionActivityUpdate activityUpdateBlock;

@end
