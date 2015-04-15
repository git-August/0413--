//
//  ViewController.m
//  0413-淘宝列表
//
//  Created by Ibokan on 15/4/13.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import "ViewController.h"
#import "goodCell.h"
#pragma mark tableview（包括cell）长什么样靠模型对象提供；tableview上的cell（行）的显示和行为靠代理实现
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * _goodsarr;
    NSMutableArray * _deletecellarr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _TrashBtn.enabled = NO;

    NSString * listfullpath = [[NSBundle mainBundle] pathForResource:@"goods.plist" ofType:nil];
    NSArray * goods = [NSMutableArray arrayWithContentsOfFile:listfullpath];
    //建立空数组,用于存放模型对象
    _goodsarr = [NSMutableArray array];
    
    for (NSDictionary * good in goods) {
        goodCell * goodcell = [goodCell cellWithdict:good];
        [_goodsarr addObject:goodcell];
    }
    _deletecellarr = [NSMutableArray array];
}
//初始化和刷新视图进入此方法,显示n行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%ld=======_deletecellarr",_deletecellarr.count);
    
    if (_deletecellarr.count == 0) {
        _taobaoNum.text = @"淘宝";
        _TrashBtn.enabled = NO;
    }
    else {
        _taobaoNum.text = [NSString stringWithFormat:@"淘宝(%ld)",_deletecellarr.count];
        _TrashBtn.enabled = YES;
    }

    return _goodsarr.count;
}
//初始化时和新视图进入视野时进入此方法,显示n行的cell,调用局部刷新不进入此方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"hehe";
    UITableViewCell * cell = [_tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    goodCell * good = _goodsarr[indexPath.row];
    /*//麻烦的写法
    cell.textLabel.text = [[_goodsarr objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString * imgname = [_goodsarr[indexPath.row] objectForKey:@"pic"];
    cell.imageView.image = [UIImage imageNamed:imgname];
    cell.detailTextLabel.text = [_goodsarr[indexPath.row] objectForKey:@"desc"];
    */
    
    NSString * picname = good.picname;
    cell.imageView.image = [UIImage imageNamed:picname];
    cell.textLabel.text = good.goodname;
    cell.detailTextLabel.text = good.descname;
    if ([_deletecellarr containsObject:good]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;

    }

        return cell;
}
#pragma mark 上边打了对勾下边也有,error,使用数组记录。
//选中一行就进入此方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableview可以得到任一行的cell，tableview和cell各自独立,不应过多耦合，万一cell拿到其他地方用呢？
//    UITableViewCell * cell = [_tableview cellForRowAtIndexPath:indexPath];
//    cell.AccessoryType = UITableViewCellAccessoryCheckmark;
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
#pragma mark tableview通过行索引对象得到一个cell,思考一下为什么？cell不是tableview的属性又不是子类，产生关系的途径有且只有方法。
//     UITableViewCell * cell = [_tableview cellForRowAtIndexPath:indexPath];
    
#pragma mark 数组空间存放待删除的行对象
#pragma mark tableview通过属性得到的不是cell对象而是描述一行属性的对象goodcell
    goodCell * good = _goodsarr[indexPath.row];
    if ([_deletecellarr containsObject:good]) {
        [_deletecellarr removeObject:good];
    }
    else {
        [_deletecellarr addObject:good];
        
    }
    //    [_tableview reloadData];//没有动画效果
    //这里取出nsarray * 的indexpath比较怪异,直接把indexpath放入@[]数组中了。
    [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

//未选中一行就进入此方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [_tableview cellForRowAtIndexPath:indexPath];
//    cell.AccessoryType = UITableViewCellAccessoryNone;
}
//调整一下tableview的高度，重新进入视野调用/初始化
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (IBAction)Trash:(UIBarButtonItem *)sender {
    NSMutableArray * patharr = [NSMutableArray array];
    for (goodCell * good in _deletecellarr) {
//        NSLog(@"_deletecellarr.count----%ld",_deletecellarr.count);
        NSInteger index = [_goodsarr indexOfObject:good];
//        NSLog(@"%ld----",index);
        NSIndexPath * path = [NSIndexPath indexPathForRow:index inSection:0];
#pragma mark error:先删模型，再删cell;调用deleterows方法相当于局部刷新，需要重载数据源，此时发现数据源数目和cell数目不一致导致崩溃。
//        [_goodsarr removeObject:good];
        [patharr addObject:path];
    }
    [_goodsarr removeObjectsInArray:_deletecellarr];
    [_deletecellarr removeAllObjects];
//    NSLog(@"patharr-----%@",patharr);
#pragma mark 当心：调用下面这个方法，只有在有新的cell进入视野才会进入cellforrows这个方法，所以当当前cell都在视野内时,不刷新淘宝个数/不禁止删除按钮
    [_tableview deleteRowsAtIndexPaths:patharr withRowAnimation:UITableViewRowAnimationMiddle];
//    [_tableview reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
