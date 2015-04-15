//
//  goodCell.m
//  0413-淘宝列表
//
//  Created by Ibokan on 15/4/15.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import "goodCell.h"

@implementation goodCell
-(id)initWithdict:(NSDictionary *)dict{
    if (self = [super init]) {
        //字典转模型,字典名放入模型名,字典图片名放入模型图片名,字典描述名放入模型对象描述名属性
        //模型对象属性重用性需要封装来实现
        self.goodname = dict[@"name"];
        self.picname = dict[@"pic"];
        self.descname = dict[@"desc"];
    }
    return self;
}
+(id)cellWithdict:(NSDictionary *)dict{
    return [[self alloc] initWithdict:dict];
}
@end
