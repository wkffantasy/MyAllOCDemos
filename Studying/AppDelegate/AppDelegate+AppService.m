//
//  AppDelegate+AppService.m
//  Studying
//
//  Created by wangkongfei on 2019/4/4.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import "AppDelegate+AppService.h"

//controller
#import "TabBarController.h"

@implementation AppDelegate (AppService)


/**
 初始化窗口
 */
- (void)initWindow {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}


/**
 初始化主界面
 */
- (void)initMainController {
    
    self.window.rootViewController = [[TabBarController alloc]init];
    
}


@end
