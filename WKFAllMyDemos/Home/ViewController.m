//
//  ViewController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/5.
//  Copyright © 2016年 fantasy. All rights reserved.
//

//controller
#import "ViewController.h"

#import "MarqueeController.h"
#import "AlphabetController.h"
#import "NoMarginScrollController.h"
#import "VideoDemoController.h"
#import "HaveMarginScrollController.h"


//view
#import "HomeCell.h"


//model
#import "HomeModel.h"

//lib or others


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray * dataArray;

@property (weak, nonatomic) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.title = @"demos";
  
  NSArray * dictArray = @[
                          @{
                            @"title":@"Label的跑马灯效果",
                            @"titleDescription":@"当文字超过一定的长度的时候，该文字会一直轮播下去，也就是跑马灯的效果",
                            @"status":@"已经完成",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToMarqueeController)),
                            },
                          
                          @{
                            @"title":@"字母表的滑动",
                            @"titleDescription":@"一个有section 和 cell的tableView，右侧有一个 字母表。上下滑动字母表，一个简单的动画，模仿的智联招聘",
                            @"status":@"已经完成",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToAlphabetController)),
                            },
                          @{
                            @"title":@"scroll item的无缝无限循环滚动",
                            @"titleDescription":@"一个scrollView 里面有好多图片 或者item，可以一直左滑 也可以一直右滑，使用frame做的，目前没有用到Masonry",
                            @"status":@"已经完成",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToNoMarginScrollController)),
                            },
                          @{
                              @"title":@"scroll item的间隙无限循环滚动",
                              @"titleDescription":@"scroll 的item之间是有一定的间距的，当然这个间距如果是0并且item的宽度是屏幕的宽度的话，和上一个就一模一样了，目前 这个有两点待优化，一是，item必须还得在view里面写，不能在controller里面写，这个没有封装好。二是，item滑到第一个或者最后一个，会有一个小小的闪现的问题",
                              @"status":@"待优化",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToHaveMarginScrollController)),
                              },

                          @{
                              @"title":@"自己写的视频播放器",
                              @"titleDescription":@"目前打算写一个自己的视频播放器，在快进快退这卡住了，抽空整整，横屏也还有问题",
                              @"status":@"未完成",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToVideoPlayerDemoController)),
                              },
                          
                          ];
  
  
  for (NSDictionary * dict in dictArray) {
    
    HomeModel * model = [HomeModel new];
    model.title = dict[@"title"];
    model.titleDescription = dict[@"titleDescription"];
    model.status = dict[@"status"];
    model.jumpTo = dict[@"jumeTo"];
    [self.dataArray addObject:model];
    
  }
  UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight) style:UITableViewStylePlain];
  tableView.delegate = self;
  tableView.dataSource = self;
  tableView.rowHeight = UITableViewAutomaticDimension;
  tableView.estimatedRowHeight = 50;
  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  _tableView = tableView;
  [self.view addSubview:tableView];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.dataArray.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  HomeCell * cell = [HomeCell cellWithTableView:tableView];
  
  HomeModel * model = self.dataArray[indexPath.row];
  
  cell.model = model;
  
  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  HomeModel * model = self.dataArray[indexPath.row];
  
  [self performSelector:NSSelectorFromString(model.jumpTo)];

}
//跳转的所有的controller
- (void)jumpToAlphabetController{
  
  [self.navigationController pushViewController:[AlphabetController new] animated:YES];
}
- (void)jumpToMarqueeController{

  [self.navigationController pushViewController:[MarqueeController new] animated:YES];
  
}
- (void)jumpToNoMarginScrollController{
  
  [self.navigationController pushViewController:[[NoMarginScrollController alloc]init] animated:YES];
  
}
- (void)jumpToVideoPlayerDemoController{
    
  [self.navigationController pushViewController:[[VideoDemoController alloc]init] animated:YES];
    
}
- (void)jumpToHaveMarginScrollController{
    
    [self.navigationController pushViewController:[HaveMarginScrollController new] animated:YES];
    
}


- (NSMutableArray *)dataArray{
  
  if (_dataArray == nil) {
    _dataArray = [NSMutableArray array];
  }
  return _dataArray;
  
}



@end
