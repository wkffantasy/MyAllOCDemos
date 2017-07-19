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
#import "WaveAnimationController.h"
#import "MoveAnimateController.h"
#import "EditCellController.h"
#import "SubclassController.h"

#import "RunTimeController.h"
#import "WebViewController.h"
#import "BaiduMapController.h"
#import "AlbumController.h"
#import "VideoRecordController.h"

//view
#import "HomeCell.h"
#import "HeaderSelectView.h"


//model
#import "HomeModel.h"

//lib or others
#import "Masonry.h"


@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) HeaderSelectView * headerView;
@property (weak, nonatomic) UIScrollView * scrollView;


@property (strong, nonatomic) NSMutableArray * dataArray;
@property (weak, nonatomic) UITableView * tableView;

@end

@implementation ViewController

-(void)viewDidDisappear:(BOOL)animated {
  
  [super viewDidDisappear:animated];
  self.navigationController.navigationBar.hidden = NO;
  
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.hidden = YES;
  
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  NSArray * selectTitlesArray = @[
                                  @"OC-demos",
                                  @"OC-class",
                                  ];
  @weakify(self);
  HeaderSelectView * headerView = [[HeaderSelectView alloc]initWithTitleArray:selectTitlesArray andSeletedColor:RGBCOLOR(74, 153, 255) andNormalColor:RGBCOLOR(134, 134, 134)];
  headerView.clickButton = ^(int tag){
    @strongify(self);
    NSLog(@"clickButton tag == %d",tag);
    [self clickButtonToScrollToIndex:tag-100];
    
  };
  CGFloat headerH = 40;
  _headerView = headerView;
  [self.view addSubview:headerView];
  [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.top.mas_equalTo(20);
    make.left.and.right.mas_equalTo(0);
    make.height.mas_equalTo(headerH);
    
  }];
  
  UIScrollView * scrollView = [[UIScrollView alloc]init];
  scrollView.contentSize = CGSizeMake(ScreenWidth * selectTitlesArray.count, ScreenHeight - headerH - 20);
  scrollView.delegate = self;
  scrollView.pagingEnabled = YES;
  scrollView.showsHorizontalScrollIndicator = NO;
  _scrollView = scrollView;
  [self.view addSubview:scrollView];
  
  [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.and.right.and.bottom.mas_equalTo(0);
    make.top.mas_equalTo(headerView.mas_bottom);
    
  }];
  
  SubclassController * classVC = [[SubclassController alloc]init];
  classVC.dataArray = [self allDemosArray];
  classVC.clickCell = ^(HomeModel *model){
    
    @strongify(self);
    [self performSelector:NSSelectorFromString(model.jumpTo)];
    
  };
  [self.scrollView addSubview:classVC.tableView];
  [self addChildViewController:classVC];
  [classVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(0);
    make.width.mas_equalTo(ScreenWidth);
    make.height.mas_equalTo(scrollView.contentSize.height);
    make.left.mas_equalTo(0);

  }];
  
  SubclassController * demoVC = [[SubclassController alloc]init];
  demoVC.dataArray = [self classArray];
  demoVC.clickCell = ^(HomeModel *model){
    
    @strongify(self);
    [self performSelector:NSSelectorFromString(model.jumpTo)];
    
  };
  [self.scrollView addSubview:demoVC.tableView];
  [self addChildViewController:demoVC];
  [demoVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(0);
    make.width.mas_equalTo(ScreenWidth);
    make.height.mas_equalTo(scrollView.contentSize.height);
    make.left.mas_equalTo(ScreenWidth);

  }];

}

- (void)clickButtonToScrollToIndex:(int)index{
  
  [self.scrollView setContentOffset:CGPointMake(index * ScreenWidth, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
  int index = self.scrollView.contentOffset.x / ScreenWidth + 100;
  NSLog(@"index == %d",index);
  [self.headerView updateSelectedIndex:index];
  
}


#pragma oc-demos
//跳转的所有的controller

- (void)jumpToWaveAnimationController {
  
  [self.navigationController pushViewController:[WaveAnimationController new] animated:YES];
  
}
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
- (void)jumpToEditViewController{
    [self.navigationController pushViewController:[EditCellController new] animated:YES];
}

- (void)jumpToMoveAnimationController{
  
  [self.navigationController pushViewController:[MoveAnimateController new] animated:YES];
  
}

#pragma oc-class

- (void)jumpToRunTimeController{
   [self.navigationController pushViewController:[RunTimeController new] animated:YES];
}

- (void)jumpToWebViewController{
   [self.navigationController pushViewController:[WebViewController new] animated:YES];
}
- (void)jumpToBaiduMapController{
    [self.navigationController pushViewController:[BaiduMapController new] animated:YES];
}
- (void)jumpToVideoRecordController{
    [self.navigationController pushViewController:[VideoRecordController new] animated:YES];
}
- (void)jumpToAlbumController{
    [self.navigationController pushViewController:[AlbumController new] animated:YES];
}

//dataSource

- (NSArray *)classArray {
  
  NSArray * dictArray = @[
                          @{
                            @"title":@"RunTime",
                            @"titleDescription":@"runtime的一个学习",
                            @"status":@"完成吧",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToRunTimeController)),
                            },
                          @{
                             @"title":@"Webview and WKWebView",
                             @"titleDescription":@"试一试",
                             @"status":@"test",
                             @"jumeTo":NSStringFromSelector(@selector(jumpToWebViewController)),
                             },
                          @{
                              @"title":@"baidu map",
                              @"titleDescription":@"试一试",
                              @"status":@"learning",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToBaiduMapController)),
                              },
                          @{
                              @"title":@"视频录制",
                              @"titleDescription":@"试一试",
                              @"status":@"learning",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToVideoRecordController)),
                              },
                          @{
                              @"title":@"打开相册",
                              @"titleDescription":@"试一试",
                              @"status":@"learning",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToAlbumController)),
                              },

        
                          ];
  
  NSMutableArray * dataArray = [NSMutableArray array];
  
  for (NSDictionary * dict in dictArray) {
    
    [dataArray addObject:[self dictToHomeModel:dict]];
    
  }
  return dataArray;
  
}

- (NSArray *)allDemosArray {
  
  NSArray * dictArray = @[
                          @{
                              @"title":@"一个可编辑的tableView的cell",
                              @"titleDescription":@"。。。。",
                              @"status":@"完成",
                              @"jumeTo":NSStringFromSelector(@selector(jumpToEditViewController)),
                              },
                          @{
                            @"title":@"一个tableView的滑动带动 弧形和header的滑动",
                            @"titleDescription":@"。。。。",
                            @"status":@"完成",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToMoveAnimationController)),
                            },
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
                          
                          @{
                            @"title":@"模仿拉勾app 我 界面的wave形式",
                            @"titleDescription":@"一个wave浪 一波接一波",
                            @"status":@"在写",
                            @"jumeTo":NSStringFromSelector(@selector(jumpToWaveAnimationController)),
                            },
                          
                          
                          ];
  
  NSMutableArray * dataArray = [NSMutableArray array];
  
  for (NSDictionary * dict in dictArray) {
    
    [dataArray addObject:[self dictToHomeModel:dict]];
  
  }
  return dataArray;
  
}
- (HomeModel *)dictToHomeModel:(NSDictionary *)dict {
  
  HomeModel * model = [HomeModel new];
  model.title = dict[@"title"];
  model.titleDescription = dict[@"titleDescription"];
  model.status = dict[@"status"];
  model.jumpTo = dict[@"jumeTo"];
  return model;
  
}

- (NSMutableArray *)dataArray{
  
  if (_dataArray == nil) {
    _dataArray = [NSMutableArray array];
  }
  return _dataArray;
  
}
/*
 押一付三
  1700*4 - 600 = 
 6800
 6200
 */



@end
