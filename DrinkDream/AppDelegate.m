//
//  AppDelegate.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/7.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.userData = [[User alloc]init];
    [self settingsModification];
    [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];

    // Override point for customization after application launch.
    return YES;
}
-(void)settingsModification{
    //建立Plist
    //self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    NSUserDefaults * nud = [NSUserDefaults standardUserDefaults];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    // 這裡判斷是否第一次開啓ＡＰＰ
    if (![nud boolForKey:@"everLaunched"]) {
        [nud setBool:YES forKey:@"everLaunched"];
        [nud setBool:YES forKey:@"firstLaunch"];
        
//        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SpotLightViewController"];
//        self.window.rootViewController = viewController;
        NSLog(@"firstLaunch");

    }
    else{
        [nud setBool:NO forKey:@"firstLaunch"];
//        UIViewController *secController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//        self.window.rootViewController = secController;
        NSLog(@"Not firstLaunch");
     

    }
    NSLog(@"%@",NSHomeDirectory());
    //[self.window makeKeyAndVisible];

    [nud synchronize];
    /*
     int count = 0;
     //read data from plist
     //    count  = [nud integerForKey:@"COUNT_NOT"];
     //    NSLog(@"%d",count);
     //    BOOL check = [nud boolForKey:@"XXX"];
     //    NSLog(@"%@",check?@"YES":@"NO");
     count = [nud integerForKey:@"COUNT"];
     //count++;
     //save to plist
     //    [nud setInteger:count forKey:@"COUNT"];
     //    [nud synchronize];
     NSLog(@"%@",NSHomeDirectory());
     NSLog(@"%d",count);
     if([nud objectForKey:@"DATE"]==nil){
     [nud setObject:@"20140820" forKey:@"DATE"];
     }else{
     NSString *dateStr = [nud objectForKey:@"DATE"];
     NSString *today = @"20140821";
     if([today isEqualToString:dateStr]){
     count++;
     [nud setInteger:count forKey:@"COUNT"];
     }else{
     [nud setObject:today forKey:@"DATE"];
     count=1;
     [nud setInteger:count forKey:@"COUNT"];
     }
     }
     [nud synchronize];
     */
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"Tips"
                                                                message:@"It's Time to Drink"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];

    [notificationAlert show];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"Tips"    message:@"It's Time to Drink"
                                                               delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [notificationAlert show];

    //----[self saveStatus];

    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    /* ----------saveStatus-----------
     
     - (void) saveStatus{
     NSMutableArray * array = [[NSMutableArray alloc] init];
     for (DragView *drag in [self.window subviews]) {
        CGPoint center = drag.center;
        NSString * centerStr = NSStringFromCGPoint(center);
        [array addObject:centerStr];
        //NSLog(@"%@", centerStr);
     
     }
     NSLog(@"ARRAY COUNT : %d", [array count]);
     NSString * targetFile = [self getTargetFile];
     [array writeToFile:targetFile atomically:YES];
     
     }
     
     - (NSString *) getTargetFile{
     NSString * homeDir = NSHomeDirectory();
     NSString * docDir = [homeDir stringByAppendingPathComponent:@"Documents"];
     NSString * targetFile = [docDir stringByAppendingPathComponent:@"data.plist"];
     return targetFile;
     }
     - (void) restoreStatus{

     NSArray * array = [[NSArray alloc] initWithContentsOfFile:[self getTargetFile]];
     if(array && array.count == MAX_FACES){
     
     for (int i = 0; i < MAX_FACES; i++) {
     DragView * drag = [[self.window subviews] objectAtIndex:i];
     NSString * centerStr = [array objectAtIndex:i];
     CGPoint center = CGPointFromString(centerStr);
     drag.center = center;
     }
     }
     
     }
    */
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    //[self restoreStatus];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
