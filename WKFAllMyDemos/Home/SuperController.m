//
//  SuperController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/6.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "SuperController.h"

@interface SuperController ()

@end

@implementation SuperController

- (void)viewDidLoad {
  [super viewDidLoad];
    
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupNaviViews];
  
}

- (void)setupNaviViews{
  
  UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  
  negativeSpacer.width = -16; // it was -6 in iOS 6
  
  UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(backTap:)];
  
  left.tintColor = HEXRGBCOLOR(0x454545);
  self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
  
  
  //下面的right只是让titleView居中，
  UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRight)];
  
  right.tintColor = [UIColor clearColor];
  self.navigationItem.rightBarButtonItems = @[negativeSpacer, right];
  
  
  NavigationTitleView * titleView = [[NavigationTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 30) Text:@"" andTitleFont:[UIFont systemFontOfSize:18] andTitleColor:HEXRGBCOLOR(0x454545)];
  
  _titleView = titleView;
  self.navigationItem.titleView = titleView;
  
}
- (void)clickRight{

}
//点击返回
- (void)backTap:(UITapGestureRecognizer *)tap{
  
  [self.navigationController popViewControllerAnimated:YES];
  
}

@end
