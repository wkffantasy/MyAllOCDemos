//
//  MarqueeController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/5.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "MarqueeController.h"

#import "NavigationTitleView.h"

@interface MarqueeController ()

@end

@implementation MarqueeController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  CGRect frame1 = CGRectMake(30, 100, ScreenWith - 100, 40);
  
  NavigationTitleView * titleView1 = [[NavigationTitleView alloc]initWithFrame:frame1 Text:@"缓缓飘落的枫叶像思念，我点燃烛火温暖岁末的秋天" andTitleFont:nil andTitleColor:[UIColor redColor]];
  [self.view addSubview:titleView1];
  
  [self.titleView updateText:@"最美的不是下雨天，是曾与你躲过雨的屋檐" andTitleFont:nil andTitleColor:[UIColor redColor]];
  
  CGRect frame2 = CGRectMake(30, 150, ScreenWith - 100, 40);
  NavigationTitleView * titleView3 = [[NavigationTitleView alloc]initWithFrame:frame2 Text:@"你说把爱渐渐放下回忆走更远" andTitleFont:[UIFont systemFontOfSize:13] andTitleColor:[UIColor greenColor]];
  [self.view addSubview:titleView3];
  
  CGRect frame3 = CGRectMake(30, 230, ScreenWith - 100, 40);
  NavigationTitleView * titleView4 = [[NavigationTitleView alloc]initWithFrame:frame3 Text:@"海天连线的地方是那夕阳" andTitleFont:[UIFont systemFontOfSize:20] andTitleColor:[UIColor blackColor]];
  [self.view addSubview:titleView4];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [titleView4 updateText:@"木造的甲板一整遍是那金黄" andTitleFont:nil andTitleColor:[UIColor grayColor]];
  });
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    [titleView4 updateText:@"你背光的轮廓就像剪影一样，充满了想象，认谁都会爱上" andTitleFont:[UIFont systemFontOfSize:13] andTitleColor:[UIColor blackColor]];
  });
}



@end
