//
//  DoSomething.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/9/5.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "UsePlist.h"

@implementation UsePlist

+(int)storeToPlist :(int)total :(int)min :(int)hour :(int)showTotal
{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    int sportsTotal = total;
    int minKey = min;
    int hourKey = hour;
    int showTotalKey = showTotal;
    [nud setInteger:showTotalKey forKey:@"showTotalKey"];
    [nud setInteger:sportsTotal forKey:@"sportsTotalKey"];
    [nud setInteger:minKey forKey:@"minKeyKey"];
    [nud setInteger:hourKey forKey:@"hourKeyKey"];
    [nud synchronize];
    
    int lastTotal = [nud integerForKey:@"drinkTotalKey"] + [nud integerForKey:@"sportsTotalKey"];
    
    return lastTotal;
}

+(void)storeArrayToPlist:(NSMutableArray *)imageArray:(NSMutableArray *)mlArray{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    [nud setObject:imageArray forKey:@"dataArrayKey"];
    [nud setObject:mlArray forKey:@"mlArrayKey"];
    [nud synchronize];
}
+(int)readToPlist:(int)lastTotal{
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    
    lastTotal = [nud integerForKey:@"drinkTotalKey"] + [nud integerForKey:@"sportsTotalKey"];
    
    //_resultLabel.text =  [NSString stringWithFormat:@"%d",lastTotal];
    
    int count = lastTotal;
    int totalForDb = lastTotal;
    int sportsTotalZero = 0;
    [nud setInteger:sportsTotalZero forKey:@"sportsTotalKey"];
    [nud setInteger:totalForDb forKey:@"totalForDbKey"];
    [nud synchronize];
    return lastTotal;

}
@end
