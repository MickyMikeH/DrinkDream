//
//  SportsViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/8.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "SportsViewController.h"
#import <sqlite3.h>
#import "UsePlist.h"
#import "GetCurrentTime.h"

@interface SportsViewController ()

@end

@implementation SportsViewController


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
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    UILabel *durationLabel = [[UILabel alloc]init];
    UILabel *sportsDrink = [[UILabel alloc]init];
    self.durationLabel.text = @"0h : 0m";
    self.sportsDrink.text = @"0 ml";
}
-(void)initView{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    self.sportsDrink.text =  [NSString stringWithFormat:@"%d ml",[nud integerForKey:@"showTotalKey"]];
    self.sportsDrink.hidden = NO;
    
    self.durationLabel.text = [NSString stringWithFormat:@"%dh : %dm",[nud integerForKey:@"hourKeyKey"],[nud integerForKey:@"minKeyKey"]];
    self.durationLabel.hidden = NO;

    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"儲存" style:UIBarButtonItemStyleDone target:self action:@selector(saveHandler:)];
    self.navigationItem.rightBarButtonItem = save;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

*/
- (IBAction)durationHandler:(id)sender {
    
    self.duration = [[UIActionSheet alloc]initWithTitle:@"Selected" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];

     self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.0f, 44.0f, 0.0f, 0.0f)];
     self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
     NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"HH:mm"];
    [self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];

     UIToolbar *pickerDateToolBar = [[UIToolbar alloc]  initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44)];
     pickerDateToolBar.barStyle = UIBarStyleBlackOpaque;
    
     [pickerDateToolBar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];

    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelButtonPressed:)];
    [barItems addObject:cancelBtn];
    
    [pickerDateToolBar setItems:barItems animated:YES];
     [self.duration addSubview:pickerDateToolBar];
     [self.duration addSubview:self.datePicker];
     [self.duration showInView:self.view];
     [self.duration setBounds:CGRectMake(0,0,320, 475)];
}

-(void)datePicker:(UIDatePicker *)sender
{
    sec = (int)sender.countDownDuration;
    min = (sec / 60) % 60;
    hour = (sec / 3600) % 60;
    self.durationLabel.text = [NSString stringWithFormat:@"%dh : %dm",hour,min];
    self.durationLabel.hidden = NO;
    
    NSLog(@"%d %d",min ,sec);
}

-(void)cancelButtonPressed:(id)sender
{
    NSLog(@"cancelButtonPressed");
    [self.duration dismissWithClickedButtonIndex:0 animated:YES];
}
- (IBAction)sportsHandler:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            NSLog(@"輕度(11/m)");
            small = 11;
            total = (sec / 60) * small;
            break;
        case 1:
            NSLog(@"中度(13/m)");
            mid = 13;
            total = (sec / 60) * mid;
            break;
        case 2:
            NSLog(@"重度(16/m");
            big = 16;
            total = (sec / 60) * big;
            break;
        default:
            break;
    }
    showTotal = total;
    self.sportsDrink.text = [NSString stringWithFormat:@"%d ml",showTotal];
    self.sportsDrink.hidden = NO;

}
-(void)saveHandler:(id)sender{
    
    int lastTotal = [UsePlist storeToPlist:total :min :hour :showTotal];
    NSLog(@"total %d",total);
    
    //NSLog(@"%d %d", totalForDb , lastTotal);
    [self updateDB:lastTotal:((int)(sec/60)):total :[GetCurrentTime getCurrentTime]];
    //NSLog(@"totalFor Db %d  min %d");
    [self performSegueWithIdentifier:@"toMain" sender:self];
}

-(void)updateDB:(int)lastTotal :(int)min :(int)sports :(NSString *)date
{
    NSString *targetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DrinkSQL.sqlite"];
    sqlite3 *database;
    sqlite3_stmt *stmt;
    //NSString * => const char*
    //連線
    if(sqlite3_open([targetPath UTF8String], &database) == SQLITE_OK){
        const char * sqlCmd = "UPDATE User SET DrinkSuggest = (?), SportsTime = (?), SportsSuggest = (?) WHERE Date = (?); ";
        int result = sqlite3_prepare_v2(database, sqlCmd, -1, &stmt, NULL);
        if(result == SQLITE_OK){
            //問號編號是 1 , -1 代表資料全部 , SQLITE_TRANSACTION 資料全選
            sqlite3_bind_int(stmt,1,lastTotal);
            sqlite3_bind_int(stmt, 2, min);
            sqlite3_bind_int(stmt,3,sports);
            sqlite3_bind_text(stmt,4,[date UTF8String],-1,SQLITE_TRANSIENT);
            sqlite3_step(stmt);
        }else{
            NSLog(@"Update data error!");
        }
    }
    sqlite3_close(database);
}
@end
