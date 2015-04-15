//
//  goodCell.h
//  0413-淘宝列表
//
//  Created by Ibokan on 15/4/15.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import <Foundation/Foundation.h>
//看到了淘宝列表一行一行的cell对象具有相同的name/pic/desc属性,于是抽象出一个类来封装
@interface goodCell : NSObject
@property (nonatomic,copy) NSString * goodname;
@property (nonatomic,copy) NSString * picname;
@property (nonatomic,copy) NSString * descname;

- (id)initWithdict:(NSDictionary *)dict;
+ (id)cellWithdict:(NSDictionary *)dict;

@end
