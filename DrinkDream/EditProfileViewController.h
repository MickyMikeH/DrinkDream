//
//  ProfileViewController.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/8.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *suggestView;
@property (strong, nonatomic) IBOutlet UITextField *heightText;
@property (strong, nonatomic) IBOutlet UITextField *weightText;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UILabel *bmiresult;
@property (strong, nonatomic) IBOutlet UILabel *drinkTotal;

- (IBAction)saveBtn:(id)sender;

@end

int drinkTotal;
int weightInt;
float height;
float weight;
float bmi;