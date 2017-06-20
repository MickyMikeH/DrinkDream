//
//  ClockTableViewController.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/25.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "ClockTableViewController.h"

@interface ClockTableViewController ()

@end

@implementation ClockTableViewController

UILocalNotification *alert1;
UILocalNotification *alert2;
UILocalNotification *alert3;
int tagswitch;
BOOL flag;
int columnCount;
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
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wallpaper.png"]];

    [self initView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];

    columnCount = 1;
    flag = NO;
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
    return columnCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
     return 1;
        
     }else
     
     return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellClcok = [tableView dequeueReusableCellWithIdentifier:@"ClockCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellClcok.textLabel.text = @"提醒";
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            switchview.on = flag;
            switchview.tag = 1;
            [switchview addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            //switchview.selected = 0;
            cellClcok.accessoryView = switchview;
        }
    }else{
        if(indexPath.row == 0){
        cellClcok.textLabel.text = @"60 秒 <測試>";
        }else if(indexPath.row == 1){
        cellClcok.textLabel.text = @"4 小時";
        }else if (indexPath.row ==2){
        cellClcok.textLabel.text = @"6 小時";
        }else if (indexPath.row ==3){
        cellClcok.textLabel.text = @"Custom";
        }
        if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
        {
            cellClcok.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            
            cellClcok.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    return cellClcok;
}
- (void)updateSwitchAtIndexPath:(UISwitch *)switchview{
    if (switchview.tag == 1) {
        flag = switchview.isOn;
        if ([switchview isOn]) {
            columnCount = 2;
            [self.tableView reloadData];
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>> ON");
        }else{
            columnCount = 1;
            [self.tableView reloadData];
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>> OFF");
            NSLog(@"cancelAllLocalNotifications");
            
            
        }
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                NSLog(@"startLocalNotification 1 min");
                alert1 = [[UILocalNotification alloc] init];
                alert1.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
                //alert1.repeatInterval = 5;
                alert1.alertBody = @"60 sec test";
                [[UIApplication sharedApplication] scheduleLocalNotification:alert1];
                break;
            case 1:
                NSLog(@"startLocalNotification 4 hours");
                alert2 = [[UILocalNotification alloc] init];
                alert2.repeatInterval = 14400;
                alert2.fireDate = [NSDate dateWithTimeIntervalSinceNow:14400];
                alert2.alertBody = @"14400 sec test";
                alert2.timeZone = [NSTimeZone defaultTimeZone];
                [[UIApplication sharedApplication] scheduleLocalNotification:alert2];
                break;
            case 2:
                NSLog(@"startLocalNotification 6 hours");
                alert3 = [[UILocalNotification alloc] init];
                alert3.fireDate = [NSDate dateWithTimeIntervalSinceNow:21600];
                alert3.alertBody = @"21600 sec test";
                alert3.timeZone = [NSTimeZone defaultTimeZone];
                [[UIApplication sharedApplication] scheduleLocalNotification:alert3];
                break;
            case 3:
                //[self performSegueWithIdentifier:@"toEditClockView" sender:self];
                break;
            default:
                break;
        }
        
        //[[UIApplication sharedApplication] scheduleLocalNotification:self.notification];

        
    }
    self.lastIndexPath = indexPath;
    
    [tableView reloadData];
}
//- (void)addNewSchedult:(NSDate *)date {
//    UIApplication* app = [UIApplication sharedApplication];
//    UILocalNotification* notifyAlarm = [[UILocalNotification alloc] init];
//    if (notifyAlarm) {
//        notifyAlarm.fireDate = date;
//        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
//        notifyAlarm.repeatInterval = 0;
//        notifyAlarm.soundName = @"";
//        notifyAlarm.alertBody = [NSString stringWithFormat: @"Be happy ^_^\n%@", date];
//        [app scheduleLocalNotification:notifyAlarm];
//    }
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 switch (section) {
     case 0:
         return @"";
         break;
     case 1:

         return @"提醒間距";
         break;
     default:
         return @"";
         break;
 }
 
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    if(section == 1){
    view.tintColor = [UIColor blackColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    }
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
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
