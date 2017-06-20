//
//  AppDelegate.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/7.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MainViewController.h"
#import "SpotLightViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) User * userData;
@property (nonatomic) MainViewController *mainViewController;
@property (nonatomic) SpotLightViewController *spotLightViewController;

@end
