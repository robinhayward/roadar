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
    self.roleLabel = [[UILabel alloc] init];
    self.roleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.roleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.roleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.roleLabel];
    
    self.proximityLabel = [[UILabel alloc] init];
    self.proximityLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.proximityLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
    
    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints
{
  NSDictionary *views = @{@"role": self.roleLabel, @"proximity": self.proximityLabel, @"time": self.timeLabel};
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[role]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[proximity]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[time]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[proximity][role][time]" options:0 metrics:nil views:views]];
  [super updateConstraints];
}

@end
