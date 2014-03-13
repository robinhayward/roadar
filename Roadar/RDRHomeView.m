//
//  RDRHomeView.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRHomeView.h"

@implementation RDRHomeView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.userLabel];
    
    self.userRoleLabel = [[UILabel alloc] init];
    self.userRoleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userRoleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userRoleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.userRoleLabel];
    
    self.userStateLabel = [[UILabel alloc] init];
    self.userStateLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userStateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.userStateLabel];
    
    self.proximityLabel = [[UILabel alloc] init];
    self.proximityLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.proximityLabel];
    
    self.proximityRoleLabel = [[UILabel alloc] init];
    self.proximityRoleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityRoleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityRoleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.proximityRoleLabel];
    
    self.proximityStateLabel = [[UILabel alloc] init];
    self.proximityStateLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityStateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.proximityStateLabel];
    
    self.proximityTimeLabel = [[UILabel alloc] init];
    self.proximityTimeLabel.font = [UIFont systemFontOfSize:16];
    self.proximityTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.proximityTimeLabel];
    
    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints
{
  NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
  [views addEntriesFromDictionary:@{@"user": self.userLabel, @"role": self.userRoleLabel, @"state": self.userStateLabel}];
  [views addEntriesFromDictionary:@{@"p": self.proximityLabel, @"pRole": self.proximityRoleLabel, @"pState": self.proximityStateLabel, @"pTime": self.proximityTimeLabel}];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[user]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[role]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[state]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[p]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pRole]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pState]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pTime]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[user][role][state]-20-[p][pRole][pState][pTime]" options:0 metrics:nil views:views]];
  [super updateConstraints];
}

@end
