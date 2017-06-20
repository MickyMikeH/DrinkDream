//
//  DoSomething.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/9/5.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsePlist : NSObject

+(int)storeToPlist :(int)total :(int)min :(int)hour :(int)showTotal;
+(void)storeArrayToPlist:(NSMutableArray *)imageArray:(NSMutableArray *)mlArray;
+(int)readToPlist:(int)lastTotal;
@end
