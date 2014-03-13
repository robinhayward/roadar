//
//  RDRSettingsViewController.m
//  Roadar
//
//  Created by Robin Hayward on 13/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRSettingsViewController.h"
#import "RDRSettingsView.h"

@interface RDRSettingsViewController ()

@end

@implementation RDRSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Settings", nil);
  }
  return self;
}

- (void)loadView
{
  self.view = [[RDRSettingsView alloc] init];
}

@end
