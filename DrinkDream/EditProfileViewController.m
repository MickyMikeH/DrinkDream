//
//  ProfileViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/8.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "EditProfileViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import <sqlite3.h>
#import "GetCurrentTime.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
    if ([nud objectForKey:@"heightKey"]==nil) {
        [self.navigationItem setHidesBackButton:YES];
    }else{
        [self.navigationItem setHidesBackButton:NO];
    }
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
   

    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [nud stringForKey:@"nameKey"];
    _nameText.text = name;
  
    if ([nud objectForKey:@"heightKey"]==nil) {
        _heightText.text = @"";
    }else{
        _heightText.text = [NSString stringWithFormat:@"%.0f",[nud floatForKey:@"heightKey"]];
    }
    if ([nud objectForKey:@"weightKey"]==nil) {
        _weightText.text = @"";
    }else{
        _weightText.text = [NSString stringWithFormat:@"%d",[nud integerForKey:@"weightKey"]];
    }
}

-(IBAction)keyboardDismiss:(id)sender{
    [_heightText resignFirstResponder];
    [_nameText resignFirstResponder];
    [_weightText resignFirstResponder];
}

- (IBAction)bmiHandler:(id)sender {
    height = [[_heightText text] floatValue]/100;
    weight = [[_weightText text] floatValue];
    bmi = (weight / (height * height));
    weightInt = (int)roundf(weight);
    
    if([_heightText.text isEqualToString:@""] || [_weightText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please input your detail" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        self.bmiresult.hidden = NO;
        self.bmiresult.text = [NSString stringWithFormat:@"您的BMI值是 : %.2f", bmi ];
        self.drinkTotal.hidden = NO;
        self.drinkTotal.text= [NSString stringWithFormat:@"每日建議喝水量 : %d ml", (30 * weightInt)];
    }
}
- (IBAction)saveBtn:(id)sender {
    NSLog(@"saveBtn");
    if([_heightText.text isEqualToString:@""] || [_weightText.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please input your detail" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
        NSString *name = _nameText.text;
        height = [[_heightText text] floatValue];
        int weightkey = weightInt;
        drinkTotal = (30 * weightInt);
        float bmikey = bmi;
    
        [nud setObject:name forKey:@"nameKey"];
        [nud setInteger:drinkTotal forKey:@"drinkTotalKey"];
        [nud setFloat:height forKey:@"heightKey"];
        [nud setInteger:weightkey forKey:@"weightKey"];
        [nud setFloat:bmikey forKey:@"bmiKey"];
        [nud synchronize];

        NSLog(@"%@", [GetCurrentTime getCurrentTime]);
        [self insertData:drinkTotal:[GetCurrentTime getCurrentTime]:bmikey];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
        [self performSegueWithIdentifier:@"toMain" sender:self];
    }
    
}

-(void)insertData:(int)drinkSuggest:(NSString *)date:(float)bmi{
    NSString *targetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DrinkSQL.sqlite"];
    sqlite3 *database;
    sqlite3_stmt *stmt;
    //NSString * => const char*
    //連線
    if(sqlite3_open([targetPath UTF8String], &database) == SQLITE_OK){
        const char * sqlCmd = "INSERT INTO User(DrinkSuggest ,Date ,Bmi) VALUES (?,?,?); ";
        int result = sqlite3_prepare_v2(database, sqlCmd, -1, &stmt, NULL);
        if(result == SQLITE_OK){
            //問號編號是 1 , -1 代表資料全部 , SQLITE_TRANSACTION 資料全選
            sqlite3_bind_int(stmt,1,drinkSuggest);
            sqlite3_bind_text(stmt, 2, [date UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt,3,bmi);
            sqlite3_step(stmt);
        }else{
            NSLog(@"Insert data error!");
        }
    }
    sqlite3_close(database);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end