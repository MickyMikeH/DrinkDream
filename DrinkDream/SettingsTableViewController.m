//
//  SettingsTableViewController.m
//  DrinkDream
//
//  Created by Andy Hsieh on 8/18/14.
//  Copyright (c) 2014 Systex UCom. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "EditProfileViewController.h"
#import "ClockTableViewController.h"
#import "SportsViewController.h"
#import "AnalyticsViewController.h"
#import "MainViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

NSString *actionWeight;
NSString *actionCapcity;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [self initView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initView{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    /*if (section == 0) {
        return 4;
    }else
        
    return 2;*/
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"個人資料";
        cell.detailTextLabel.text=@"";
        cell.imageView.image = [UIImage imageNamed:@"user.png"];
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"定時提醒";
        cell.imageView.image = [UIImage imageNamed:@"clock.png"];
        cell.detailTextLabel.text=@"";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"運動計算";
        cell.imageView.image = [UIImage imageNamed:@"calculator.png"];

        cell.detailTextLabel.text=@"";
    }else if (indexPath.row ==3){
        cell.textLabel.text = @"飲水資訊";
        cell.imageView.image = [UIImage imageNamed:@"information.png"];
        cell.detailTextLabel.text=@"";
    }else if (indexPath.row ==4){
        cell.textLabel.text = @"Weight";
        cell.detailTextLabel.text = actionWeight;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if (indexPath.row ==5){
        cell.textLabel.text = @"Capcity";
        cell.detailTextLabel.text = actionCapcity;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.textColor = [UIColor whiteColor];
//
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"EditProfile";
//        cell.detailTextLabel.text=@"";
//    }else if(indexPath.row == 1){
//        cell.textLabel.text = @"Notification";
//        cell.detailTextLabel.text=@"";
//    }else if(indexPath.row == 2){
//        cell.textLabel.text = @"Sports";
//        cell.detailTextLabel.text=@"";
//    }else if (indexPath.row ==3){
//        cell.textLabel.text = @"Analytics";
//        cell.detailTextLabel.text=@"";
//    }else if (indexPath.row ==4){
//        cell.textLabel.text = @"Weight";
//        cell.detailTextLabel.text = actionWeight;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//
//    }else if (indexPath.row ==5){
//        cell.textLabel.text = @"Capcity";
//        cell.detailTextLabel.text = actionCapcity;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Conditionally perform segues, here is an example:
    //int tag = 6;//this is same at table cell row number.
    //UITableViewCell *cell = (UITableViewCell*)[tableView viewWithTag:tag];

    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"toEditProfile" sender:self];
    }
    else if (indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"toNotification" sender:self];
    }
    else if (indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"toSports" sender:self];
    }
    else if (indexPath.row == 3)
    {
        [self performSegueWithIdentifier:@"toSuggest" sender:self];
    }
    else if (indexPath.row == 4){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Select weight units" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: @"kg",@"lb",nil];
        [alertView show];
        
    }
    else if (indexPath.row == 5){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Select capicity units" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: @"ml",@"oz",nil];
        [alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *alertTitle = [alertView title];
    if([alertTitle isEqualToString:@"Select weight units"]){
        
        switch (buttonIndex) {
            case 0:
                actionWeight = @"kg";
                //NSLog(@"kg");
                break;
            case 1:
                NSLog(@"lb");
                //actionWeight = @"lb";
                break;
                
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:
                //NSLog(@"ml");
                actionCapcity = @"ml";
                break;
            case 1:
                //NSLog(@"oz");
                actionCapcity = @"oz";
                break;
            default:
                break;
        }
        //[self theSamePart:buttonIndex:@"ml":@"oz"];
    }
    [self.tableView reloadData];
}

/*-(void)theSamePart:(NSInteger)aa :(NSString *)data1 :(NSString *)data2
{
    switch (aa) {
        case 0:
            NSLog(data1);
            actionCapcity = data1;
            break;
        case 1:
            NSLog(data2);
            actionCapcity = data2;
            break;
            
        default:
            break;
    }
}*/


/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"A";
            break;
        case 1:
            return @"B";
            break;
        default:
            return @"";
            break;
    }
   
}*/
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
