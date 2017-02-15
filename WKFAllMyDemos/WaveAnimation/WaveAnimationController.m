//
//  WaveAnimationController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/2/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "WaveAnimationController.h"

#import "WaveView.h"

@interface WaveAnimationController ()

@property (strong, nonatomic) WaveView * waveView;


@end

@implementation WaveAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self.view addSubview:self.animationView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WaveView *)animationView {
  if (!_waveView) {
    _waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 300)
                                                backgroundColor:[UIColor lightGrayColor]
                                                      fillColor:[UIColor redColor]
                                                       autoPlay:YES];
  }
  return _waveView;
}


@end
