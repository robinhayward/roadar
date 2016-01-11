//
//  RDRUser.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRUser.h"

NSString * const RDRUserModeDefaultKey = @"RDRUserModeDefaultKey";

@implementation RDRUser

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    [self addObserver:self forKeyPath:@"mode" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSNumber *modeNumber = [[NSUserDefaults standardUserDefaults] objectForKey:RDRUserModeDefaultKey];
    if (modeNumber) {
      self.mode = [modeNumber integerValue];
    }

  }
  return self;
}

- (void)dealloc
{
  [self removeObserver:self forKeyPath:@"mode" context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"mode"]) {
    NSNumber *modeNumber = [NSNumber numberWithInteger:self.mode];
    [[NSUserDefaults standardUserDefaults] setObject:modeNumber forKey:RDRUserModeDefaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

@end
