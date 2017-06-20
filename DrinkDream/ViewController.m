//
//  ViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/7.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)initView{
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(toMainPage) userInfo:nil repeats:NO];

}

-(void)toMainPage{
    [self performSegueWithIdentifier:@"turnMainPage" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
