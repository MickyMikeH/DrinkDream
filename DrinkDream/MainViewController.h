//
//  MainViewController.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/7.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIAlertViewDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalDrink;
@property(strong, nonatomic) UIButton *buttonView;
@property(strong, nonatomic) UIMenuController *ButtonMenu;
@property(strong, nonatomic) NSMutableArray *imageArray;
@property(strong, nonatomic) NSMutableArray *mlArray;
@property(strong, nonatomic) NSMutableArray *buttonImages;
@property(strong, nonatomic) UIImageView *waterImageView;
- (IBAction)createBtnHandler:(id)sender;


@end
int count;
int buffer;
int tagInt; //for delete
int selected ;
int lastTotal;
NSMutableArray *createButtons;
UIScrollView *scrollView ;
UITextField *textField;
NSUserDefaults *nud;
int number[6];