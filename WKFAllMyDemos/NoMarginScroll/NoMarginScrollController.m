//
//  NoMarginScrollController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/7.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NoMarginScrollController.h"

#import "WKFCircularSlidingView.h"

@interface NoMarginScrollController ()

@property (nonatomic,strong)NSMutableArray *firstViewImageArray;

@property (nonatomic,weak) UILabel * statusLabel;

@property (nonatomic, weak) WKFCircularSlidingView * circleView;

@end

@implementation NoMarginScrollController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  CGFloat scrollWidth = ScreenWith;
  CGFloat scrollHeight = scrollWidth * 40 / 64;
  
  CGRect frame=CGRectMake(0, 64, scrollWidth, scrollHeight);
  
  @weakify(self);
  //scrollView
  WKFCircularSlidingView * firstView = [[WKFCircularSlidingView alloc]initWithFrame:frame ImagesArray:self.firstViewImageArray andClickImageBlock:^(int tag) {
    @strongify(self);
    self.statusLabel.text = [NSString stringWithFormat:@"点击了第  %d  张图",tag+1];
    
  } withChangeAnImageTime:3];
  _circleView = firstView;
  
  [self.view addSubview:firstView];
  
  //label
  UILabel *statusLabel = [[UILabel alloc]init];
  statusLabel.textAlignment = NSTextAlignmentCenter;
  statusLabel.frame=CGRectMake(0, CGRectGetMaxY(firstView.frame) + 30, ScreenWith, 30);
  statusLabel.text = @"还没有上面点击图片";
  _statusLabel=statusLabel;
  [self.view addSubview:statusLabel];
  
}

- (void)dealloc{

  [_circleView removeTimer];
  _circleView=nil;
}

- (NSMutableArray *)firstViewImageArray{
  
  if (_firstViewImageArray==nil) {
    
    _firstViewImageArray = [NSMutableArray array];
    
    // 改变imageCount的个数 最多是9
    int imageCount = 4;
    for (int i = 0; i < imageCount; i++) {
      
      NSString *imageName = [NSString stringWithFormat:@"%02d",i+1];
      [_firstViewImageArray addObject:imageName];
      
    }
  }
  return _firstViewImageArray;
}

@end
