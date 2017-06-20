//
//  MainViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/7.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>
#import "GetCurrentTime.h"
#import "UsePlist.h"
@interface MainViewController ()
@end


@implementation MainViewController

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
    [self.navigationItem setHidesBackButton:YES];
    [self initView];
    //self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self readNSU];
}
-(void)initView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wall1_600.png"]];
    //建立Navigation 左邊按鈕
    UIButton * setting = [UIButton buttonWithType:UIButtonTypeCustom];
    setting.bounds = CGRectMake(0, 0, 45.0, 45.0);
    [setting setImage:[UIImage imageNamed:@"List_bullets.png"]forState:UIControlStateNormal];
    [setting addTarget:self action:@selector(settingHandler:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fooBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setting];
    self.navigationItem.rightBarButtonItem = fooBarButtonItem;
    
    //磅秤中央水的圖片
    UIImage *waterImage = [UIImage imageNamed:@"waterCenter.png"];
    UIImageView *waterImageView = [[UIImageView alloc]initWithImage:waterImage];
    waterImageView.frame = CGRectMake(50, 300, 100, 100);
    
    //[self.view addSubview:waterImageView index:0];
    
    //初始化
    createButtons = [[NSMutableArray alloc]init];
    nud = [NSUserDefaults standardUserDefaults];
    
    self.buttonImages = [[NSMutableArray alloc]initWithArray:[nud objectForKey:@"dataArrayKey"]];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 450, self.view.frame.size.width, 60)];
    //scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scrollView];
    if (self.buttonImages == nil || self.buttonImages.count < 5) {
        nud = [NSUserDefaults standardUserDefaults];
        self.imageArray =[[NSMutableArray alloc]initWithObjects:@"water-bottle1",@"water-bottle2", @"water-bottle3",@"water-bottle4",@"water-bottle5",nil];
        self.mlArray = [[NSMutableArray alloc]init];
        [self.mlArray addObject:[NSNumber numberWithInt:300]];
        [self.mlArray addObject:[NSNumber numberWithInt:150]];
        [self.mlArray addObject:[NSNumber numberWithInt:400]];
        [self.mlArray addObject:[NSNumber numberWithInt:550]];
        [self.mlArray addObject:[NSNumber numberWithInt:600]];
        
        [nud setObject:self.mlArray forKey:@"mlArrayKey"];
        [nud setObject:self.imageArray forKey:@"dataArrayKey"];
        [nud synchronize];

    }else{
        self.imageArray = self.buttonImages;
        self.mlArray = [[NSMutableArray alloc]initWithArray:[nud objectForKey:@"mlArrayKey"]];
    }
    //建立ScrollView的Button
    [self createScrollButton];
    [self createButtonMenu];
    [scrollView setContentSize:CGSizeMake(self.imageArray.count*70,60)];

}


//讀Plist的飲水總量
-(void)readNSU{
    
    nud = [NSUserDefaults standardUserDefaults];
    
    lastTotal = [nud integerForKey:@"drinkTotalKey"] + [nud integerForKey:@"sportsTotalKey"];

    _resultLabel.text =  [NSString stringWithFormat:@"%d",lastTotal];
    count = lastTotal;
    int totalForDb = lastTotal;
    int sportsTotalZero = 0;
    [nud setInteger:sportsTotalZero forKey:@"sportsTotalKey"];
    [nud setInteger:totalForDb forKey:@"totalForDbKey"];
    [nud synchronize];

}
//Navigation bar button 跳轉 settingView
-(void)settingHandler:(id)sender{
    [self performSegueWithIdentifier:@"toSettingView" sender:self];
    }
//水杯按鈕
-(void)buttonTapped:(UIButton *)sender{
    if ([_resultLabel.text isEqualToString:@""]) {
        return;
    }
    count -= [[self.mlArray objectAtIndex:[sender tag]] integerValue];


    //如果水量以達0跳出AlertView
    if (count <= 0) {
        count = 0;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Congratulations!" message:@"您已達成今日目標" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    //如果水量小於0數值為0
    if ([_resultLabel.text intValue] <= 0) {
        _resultLabel.text = @"0";
        return;
    }
    //現在時間 存入DB+Plist
    NSLog(@"DrinkTotal: %d", count);
    [self updateDB:count:[GetCurrentTime getCurrentTime]];
    
    self.resultLabel.text = [NSString stringWithFormat:@"%d",count];
    nud = [NSUserDefaults standardUserDefaults];
    int drinkTotal = count;
    [nud setInteger:drinkTotal forKey:@"drinkTotalKey"];
    //[nud setInteger:drinkTotal forKey:@"sportsTotalKey"];
    [nud synchronize];
}
//水杯往上增加總水量
-(void)swipeHandler:(UISwipeGestureRecognizer *)sender{
    NSLog(@"swipeUp");
    
    count += [[self.mlArray objectAtIndex:sender.view.tag] integerValue];
    if(count >= lastTotal){
        count = lastTotal;
    }
    self.resultLabel.text = [NSString stringWithFormat:@"%d",count];
    nud = [NSUserDefaults standardUserDefaults];
    int drinkTotal = count;
    [nud setInteger:drinkTotal forKey:@"drinkTotalKey"];
    //[nud setInteger:drinkTotal forKey:@"sportsTotalKey"];
    [nud synchronize];

}
//更新DB
-(void)updateDB:(int)count:(NSString *)date
{
    NSString *targetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DrinkSQL.sqlite"];
    sqlite3 *database;
    sqlite3_stmt *stmt;
    //NSString * => const char*
    //連線
    if(sqlite3_open([targetPath UTF8String], &database) == SQLITE_OK){
        const char * sqlCmd = "UPDATE User SET DrinkTotal = (?) WHERE Date = (?); ";
        int result = sqlite3_prepare_v2(database, sqlCmd, -1, &stmt, NULL);
        if(result == SQLITE_OK){
            //問號編號是 1 , -1 代表資料全部 , SQLITE_TRANSACTION 資料全選
            sqlite3_bind_int(stmt,1,count);
            sqlite3_bind_text(stmt,2,[date UTF8String],-1,SQLITE_TRANSIENT);
            sqlite3_step(stmt);
        }else{
            NSLog(@"Update data error!");
        }
    }
    sqlite3_close(database);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//新建杯子的AlertView
- (IBAction)createBtnHandler:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"請輸入杯子大小" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    textField = [alert textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
}
//新增自定義水杯
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            if(textField.text.length != 0){
                self.buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.buttonView setBackgroundImage:[UIImage imageNamed:@"water-coustom.png"] forState:UIControlStateNormal];
                self.buttonView.tag = self.imageArray.count ;
                NSLog(@"self.buttonView.tag : %d",self.buttonView.tag);
                [self.buttonView addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
                              self.buttonView.frame = CGRectMake(self.imageArray.count*60,7, 50, 50);
                //self.buttonView.layer.cornerRadius = 25;
                NSInteger inputDrink = [textField.text intValue];
                NSLog(@"inputDrink: %d",inputDrink);
                //number[tagInt] = num ;
                //[self.buttonView.layer setMasksToBounds:YES];
                //add Label
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 50, 15)];
                label.text = [NSString stringWithFormat:@"%dml", inputDrink];
                //[UIFont fontWithName:@"Arial-BoldMT" size:16]];Avenir Next Condensed Demi Bold
                label.font = [UIFont fontWithName:@"Arial-BoldMT" size:11];
                label.textAlignment = NSTextAlignmentCenter;
                [self.buttonView addSubview:label];
                [scrollView addSubview:self.buttonView];
                [self.imageArray addObject:@"water-coustom.png"];
                [self.mlArray addObject:[NSNumber numberWithInt:inputDrink] ];
                [UsePlist storeArrayToPlist:self.imageArray :self.mlArray];
                [scrollView setContentSize:CGSizeMake(self.imageArray.count *70,60)];
                self.buttonView.userInteractionEnabled = YES;
                UILongPressGestureRecognizer * longpressHandler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressHandler:)];
                [self.buttonView addGestureRecognizer:longpressHandler];
        }else{
             break;
            }
        default:
            break;
    }
}
//刪除杯子
-(void)deleteHandler:(UIMenuItem *)sender{
    NSLog(@"deleteHandler");
    NSLog(@"select tag : %d",selected);
    NSLog(@"self.imageArray.count: %d",self.imageArray.count);
    int idx = self.imageArray.count - 1 ;
    NSLog(@"select idx : %d",idx);
    //整個scrollView刪除
    for (int i = idx; i >=0 ; i--) {
        UIButton* btn =[[scrollView subviews] objectAtIndex:i];
        if(btn.tag==selected){
            [btn removeFromSuperview];
            [self.imageArray removeObjectAtIndex:i];
            [self.mlArray removeObjectAtIndex:i];
        }
    }
    //imageArray和mlArray 的plist檔案刪除
    [UsePlist storeArrayToPlist:self.imageArray :self.mlArray];
    NSLog(@"self.imageArray.count: %d",self.imageArray.count);
    
    //REPAINT
    for(UIView * view in [scrollView subviews]){
        [view removeFromSuperview];
    }
    [self createScrollButton];
    [scrollView setContentSize:CGSizeMake(self.imageArray.count*70,60)];
    [scrollView setNeedsDisplay];
}
-(void)longpressHandler:(UILongPressGestureRecognizer *)sender{
    
    NSLog(@"longpressHandler");
    
    if (sender.state == UIGestureRecognizerStateBegan){
        [self becomeFirstResponder];
        selected = sender.view.tag;
        NSLog(@"self.buttonView.tag: %d",self.buttonView.tag);
        //偵測手點擊的物件
        CGPoint pressLocation = [sender locationInView:self.view];
        //寬高設成0就是某個點，箭頭指到的點
        [self.ButtonMenu setTargetRect:CGRectMake(pressLocation.x, pressLocation.y, 0, 0) inView:self.view];
        
        [self.ButtonMenu setMenuVisible:YES animated:YES];
    }else if (sender.state == UIGestureRecognizerStateChanged){//touchesMoved
        //NSLog(@"CHANGED");
    }else if (sender.state == UIGestureRecognizerStateEnded){//touchesEnded
        //NSLog(@"ENDED");
    }
    
}
//建立Scroll+Button+Label
-(void)createScrollButton{
    for(int i = 0; i < [self.imageArray count]; i++){
        
        self.buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonView setBackgroundImage:[UIImage imageNamed :[self.imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        //[buttonView setTitle:@"test" forState:UIControlStateNormal];
        self.buttonView.tag = i;
        [self.buttonView addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
        [self.buttonView addGestureRecognizer:swipeUp];
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 50, 15)];
        label.text = [NSString stringWithFormat:@"%@ml",[self.mlArray objectAtIndex:i]];
        label.font = [UIFont fontWithName:@"Arial-BoldMT" size:11];
        label.textAlignment = NSTextAlignmentCenter;
        [self.buttonView addSubview:label];
        self.buttonView.frame = CGRectMake(i*60,7, 50, 50);
        [self.buttonView.layer setMasksToBounds:YES];
        [scrollView addSubview:self.buttonView];
        if(i>4){
            self.buttonView.userInteractionEnabled = YES;
            UILongPressGestureRecognizer * longpressHandler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressHandler:)];
            [self.buttonView addGestureRecognizer:longpressHandler];
        }
    }
}
//長按刪除新增的杯子
-(void)createButtonMenu{
    self.ButtonMenu = [[UIMenuController alloc]init];
    UIMenuItem *delete = [[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteHandler:)];
    [self.ButtonMenu setMenuItems:@[delete]];
    [self.ButtonMenu setArrowDirection:UIMenuControllerArrowDefault];
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
@end
