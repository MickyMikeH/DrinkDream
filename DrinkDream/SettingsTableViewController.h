//
//  SettingsTableViewController.h
//  DrinkDream
//
//  Created by Andy Hsieh on 8/18/14.
//  Copyright (c) 2014 Systex UCom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController<UIAlertViewDelegate>
@property (strong, nonatomic)UIActionSheet *weightAction;
@property (strong, nonatomic)UIActionSheet *capacityAction;

@end
