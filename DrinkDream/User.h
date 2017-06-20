//
//  User.h
//  DrinkDream
//
//  Created by ucom Apple 01 on 2014/8/19.
//  Copyright (c) 2014年 Systex UCom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *name;
@property (nonatomic) float weight;
@property (nonatomic) int weightInt;
@property (nonatomic) float height;
@property (nonatomic) int heightInt;

@property (nonatomic) float bmi;
@property (nonatomic) int drinkTotal;
@end
