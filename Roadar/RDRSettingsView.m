//
//  RDRSettingsView.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRSettingsView.h"

@implementation RDRSettingsView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    
    self.motionActivityLabel = [[UILabel alloc] init];
    self.motionActivityLabel.font = [UIFont boldSystemFontOfSize:16];
    self.motionActivityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.motionActivityLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.motionActivityLabel];
    
    self.beaconIdentifierLabel = [[UILabel alloc] init];
    self.beaconIdentifierLabel.font = [UIFont boldSystemFontOfSize:16];
    self.beaconIdentifierLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.beaconIdentifierLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.beaconIdentifierLabel];
    
    self.closestBeaconIdentifierLabel = [[UILabel alloc] init];
    self.closestBeaconIdentifierLabel.font = [UIFont boldSystemFontOfSize:16];
    self.closestBeaconIdentifierLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.closestBeaconIdentifierLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.closestBeaconIdentifierLabel];
    
    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints
{
  
  NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
  [views addEntriesFromDictionary:@{@"motion": self.motionActivityLabel, @"beacon": self.beaconIdentifierLabel, @"closest": self.closestBeaconIdentifierLabel}];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[motion]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[beacon]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[closest]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[motion]-5-[beacon]-5-[closest]" options:0 metrics:nil views:views]];
  [super updateConstraints];
}

@end
