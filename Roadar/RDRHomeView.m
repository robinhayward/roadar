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
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.riskView = [[UIView alloc] init];
    self.riskView.translatesAutoresizingMaskIntoConstraints = NO;
    self.riskView.backgroundColor = [UIColor clearColor];
    self.riskView.alpha = 0.8;
    [self addSubview:self.riskView];
    
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.font = [UIFont boldSystemFontOfSize:24];
    self.noticeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    self.noticeLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.noticeLabel];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = [UIFont boldSystemFontOfSize:160];
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:self.countLabel];
    
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userLabel.textAlignment = NSTextAlignmentCenter;
    self.userLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.userLabel];
    
    self.userModeLabel = [[UILabel alloc] init];
    self.userModeLabel.font = [UIFont boldSystemFontOfSize:24];
    self.userModeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userModeLabel.textAlignment = NSTextAlignmentCenter;
    self.userModeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.userModeLabel];
    
    self.userRoleLabel = [[UILabel alloc] init];
    self.userRoleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userRoleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userRoleLabel.textAlignment = NSTextAlignmentCenter;
    self.userRoleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.userRoleLabel];
    
    self.userStateLabel = [[UILabel alloc] init];
    self.userStateLabel.font = [UIFont boldSystemFontOfSize:16];
    self.userStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userStateLabel.textAlignment = NSTextAlignmentCenter;
    self.userStateLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.userStateLabel];
    
    self.proximityLabel = [[UILabel alloc] init];
    self.proximityLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityLabel.textAlignment = NSTextAlignmentCenter;
    self.proximityLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.proximityLabel];
    
    self.proximityRoleLabel = [[UILabel alloc] init];
    self.proximityRoleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityRoleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityRoleLabel.textAlignment = NSTextAlignmentCenter;
    self.proximityRoleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.proximityRoleLabel];
    
    self.proximityStateLabel = [[UILabel alloc] init];
    self.proximityStateLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityStateLabel.textAlignment = NSTextAlignmentCenter;
    self.proximityStateLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.proximityStateLabel];
    
    self.proximityTimeLabel = [[UILabel alloc] init];
    self.proximityTimeLabel.font = [UIFont systemFontOfSize:16];
    self.proximityTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.proximityTimeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.proximityTimeLabel];
    
    self.proximityUserLabel = [[UILabel alloc] init];
    self.proximityUserLabel.font = [UIFont boldSystemFontOfSize:16];
    self.proximityUserLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proximityUserLabel.textAlignment = NSTextAlignmentCenter;
    self.proximityUserLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.proximityUserLabel];
    
    self.modeButton = [[UIButton alloc] init];
    self.modeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.modeButton.backgroundColor = [UIColor darkGrayColor];
    self.modeButton.layer.cornerRadius = 5;
    [self.modeButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [self.modeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.modeButton];
    
    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints
{
  NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
  [views addEntriesFromDictionary:@{@"user": self.userLabel, @"mode": self.userModeLabel, @"role": self.userRoleLabel, @"state": self.userStateLabel, @"notice": self.noticeLabel}];
  [views addEntriesFromDictionary:@{@"p": self.proximityLabel, @"pRole": self.proximityRoleLabel, @"pState": self.proximityStateLabel, @"pTime": self.proximityTimeLabel, @"pUser": self.proximityUserLabel}];
  [views addEntriesFromDictionary:@{@"riskView": self.riskView, @"button": self.modeButton, @"count": self.countLabel}];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:30]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[riskView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[mode]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[role]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[notice]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pRole]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pState]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[pTime]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[count]-10-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[button]-10-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[riskView(144)]" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[notice(40)]-40-[pRole][pState][pTime]" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mode][role]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(44)]-10-|" options:0 metrics:nil views:views]];
  [super updateConstraints];
}

@end
