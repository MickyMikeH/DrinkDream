//
//  SpotLightViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/25.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "SpotLightViewController.h"

@interface SpotLightViewController ()

@end

@implementation SpotLightViewController

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
-(void)initView{
    [self initDB];
    UIButton * toEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    toEdit.bounds = CGRectMake(0, 0, 100.0, 40.0);
    [toEdit setImage:[UIImage imageNamed:@"start300.png"]forState:UIControlStateNormal];
   [toEdit addTarget:self action:@selector(settingHandler:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fooBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toEdit];
    self.navigationItem.rightBarButtonItem = fooBarButtonItem;
}
- (void) initDB{
    //NSLog(@"HOME : \n%@",NSHomeDirectory());
    NSString * targetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DrinkSQL.sqlite"];
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if(![fileMgr fileExistsAtPath:targetPath]){
        NSString * sourcePath = [[NSBundle mainBundle] pathForResource:@"DrinkSQL" ofType:@"sqlite"];
        [fileMgr copyItemAtPath:sourcePath toPath:targetPath error:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)settingHandler:(id)sender{
        [self performSegueWithIdentifier:@"toEditProfileFirst" sender:self];
    
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

@end
