//
//  VideoDemoController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 16/9/7.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "VideoDemoController.h"

#define urlString1   @"http://media7.smartstudy.com/pd/videos/2015/af/c7/16040/mp4/dest.m3u8"
#define urlString2   @"http://media7.smartstudy.com/pd/videos/2015/3e/5a/16041/mp4/dest.m3u8"
#define urlString3   @"http://v.smartstudy.com/pd/videos/2015/67/df/10422/mp4/dest.m3u8"

#import "Masonry.h"

#import "VideoPlayController.h"

@interface VideoDemoController ()

@end

@implementation VideoDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor grayColor];
    [playButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.and.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        
    }];
    
    [self test];
    
    
}
- (void)test {
//    static double a = 10,b = 20;//全局变量
    double a = 10,b = 20;//本地变量
    typedef double (^MultiplyBlock)(void);
    MultiplyBlock mul = ^(void){
        return a * b;
    };
    NSLog(@"a * b ==%f",mul());
    
    a = 20;
    b = 30;
    
    NSLog(@"a * b ==%f",mul());
    
          
    
    
    
}

- (void)clickButton:(UIButton *)button{
    
    VideoPlayController * vpVC = [[VideoPlayController alloc]initWithVideoPlayerScreenStatus:VideoPlayerScreenSmall andPlayUrl:urlString3];
    __weak typeof(vpVC) weakvpVC = vpVC;
  
    vpVC.buttonBack = ^{
        
        [weakvpVC dismissViewControllerAnimated:YES completion:nil];
        
    };
    vpVC.buttonStatus = ^(VideoPlayerStatus status){
        
        NSLog(@"status %lu",(unsigned long)status);
        switch (status) {
            case VideoPlayerStatusPlaying:{
                NSLog(@"isPlaying");
            }
                break;
            case VideoPlayerStatusFailed:{
                NSLog(@"play failed");
            }
                break;
                
            default:
                break;
        }
        
    };
    vpVC.buttonFullScreen = ^(VideoPlayerScreenStatus screenStatus){
        
        NSLog(@"screenStatus %lu",(unsigned long)screenStatus);
        
    };
    vpVC.buttonRate = ^(NSString * rate){
        
        NSLog(@"rate %@",rate);
        
    };
    
    [self.navigationController presentViewController:vpVC animated:YES completion:nil];
    
    
}
@end
