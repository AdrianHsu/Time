//
//  ProfileViewController.h
//  Utime
//
//  Created by AdrianHsu on 2015/5/17.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MissionItem.h"

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *missonTextField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) MissionItem *missionItem;

- (IBAction)setTime:(id)sender;
- (IBAction)startCountown:(id)sender;
- (IBAction)setMission:(id)sender;

@end
