//
//  ViewController.m
//  0413-淘宝列表
//
//  Created by Ibokan on 15/4/13.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * _plistarr;
    NSMutableArray * _deletearr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _TrashBtn.enabled = NO;

    NSString * listfullpath = [[NSBundle mainBundle] pathForResource:@"goods.plist" ofType:nil];
    _deletearr = [NSMutableArray arrayWithArray:_plistarr];
    _plistarr = [NSMutableArray arrayWithContentsOfFile:listfullpath];
    
    
}
//初始化和刷新视图进入此方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _plistarr.count;
}
//显示一行cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"hehe";
    UITableViewCell * cell = [_tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[_plistarr objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString * imgname = [_plistarr[indexPath.row] objectForKey:@"pic"];
    cell.imageView.image = [UIImage imageNamed:imgname];
    cell.detailTextLabel.text = [_plistarr[indexPath.row] objectForKey:@"desc"];
    
    NSLog(@"%@",_tableview.subviews);
        return cell;
}
#pragma mark 上边打了对勾下边也有,error,使用数组记录。
//选中一行就进入此方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableview可以得到任一行的cell
//    UITableViewCell * cell = [_tableview cellForRowAtIndexPath:indexPath];
//    cell.AccessoryType = UITableViewCellAccessoryCheckmark;


}

//未选中一行就进入此方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [_tableview cellForRowAtIndexPath:indexPath];
//    cell.AccessoryType = UITableViewCellAccessoryNone;
    
    
}















- (IBAction)Trash:(UIBarButtonItem *)sender {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
