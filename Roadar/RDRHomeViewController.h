//
//  RDRHomeViewController.h
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import "RDRViewController.h"

@class RDRHomeView, RDRTransmitter, RDRReceiver;

@interface RDRHomeViewController : RDRViewController

@property (strong, nonatomic) RDRHomeView *view;
@property (strong, nonatomic) RDRTransmitter *beacon;
@property (strong, nonatomic) RDRReceiver *receiver;

@end
