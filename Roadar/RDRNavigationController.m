//
//  RDRNavigationController.m
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRNavigationController.h"

@interface RDRNavigationController ()

@end

@implementation RDRNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
  }
  return self;
}


@end
