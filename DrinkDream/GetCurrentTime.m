//
//  GetCurrentTime.m
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/9/5.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import "GetCurrentTime.h"

@implementation GetCurrentTime

+(NSString *)getCurrentTime{
    NSDate *current = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *dateformat = [dateFormatter stringFromDate:current];
    
    return dateformat;
}
@end
