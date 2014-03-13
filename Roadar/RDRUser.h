//
//  RDRUser.h
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDRConstants.h"

extern NSString * const RDRUserModeDefaultKey;

@interface RDRUser : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (assign, nonatomic) RDRMode mode;

@end
