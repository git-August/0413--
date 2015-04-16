//
//  ViewController.h
//  0413-淘宝列表
//
//  Created by Ibokan on 15/4/13.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TrashBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)Trash:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *taobaoNum;

- (IBAction)selectall:(UIBarButtonItem *)sender;

@end

