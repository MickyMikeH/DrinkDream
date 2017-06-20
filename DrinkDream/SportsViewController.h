//
//  SportsViewController.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/8.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsViewController : UIViewController<UIActionSheetDelegate>
@property (strong, nonatomic) UIActionSheet *duration;
@property (strong, nonatomic) UIDatePicker *datePicker;
//持續時間 Label
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
//將增加今日喝水量 Label
@property (strong, nonatomic) IBOutlet UILabel *sportsDrink;
//運動種類介紹
@property (strong, nonatomic) IBOutlet UITextView *sportsView;
//持續時間編輯
- (IBAction)durationHandler:(id)sender;
//種類 segement
- (IBAction)sportsHandler:(id)sender;

@end
int small;
int mid;
int big;
int min;
int hour;
int sec;
int total;
int showTotal;