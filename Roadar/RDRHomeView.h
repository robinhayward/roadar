//
//  RDRHomeView.h
//  Roadar
//
//  Created by Robin Hayward on 12/03/2014.
//  Copyright (c) 2014 Rob Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDRHomeView : UIView

@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *userModeLabel;
@property (strong, nonatomic) UILabel *userRoleLabel;
@property (strong, nonatomic) UILabel *userStateLabel;
@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UILabel *proximityLabel;
@property (strong, nonatomic) UILabel *proximityUserLabel;
@property (strong, nonatomic) UILabel *proximityRoleLabel;
@property (strong, nonatomic) UILabel *proximityStateLabel;
@property (strong, nonatomic) UILabel *proximityTimeLabel;
@property (strong, nonatomic) UIButton *modeButton;

@property (strong, nonatomic) UIView *riskView;

@end
