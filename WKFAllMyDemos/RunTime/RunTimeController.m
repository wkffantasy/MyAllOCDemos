//
//  RunTimeController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/26.
//  Copyright © 2017年 fantasy. All rights reserved.
//

/*
 http://www.cnblogs.com/hankkk/p/5794116.html
 Runtime的用法
 
 1、发送消息。
 2,交换方法
 
 */


#import "RunTimeController.h"

#import <objc/message.h>

//view

//model
#import "Student.h"

//lib or others
#import "UIImage+UIImage_extention.h"
#import "UIImageView+testExtension.h"

@interface RunTimeController ()

@end

@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sendMessageUseRunTime];
    [self exchangeMethodUseRunTime];
    [self addMethodDynamically];
    [self addPropertyDynamically];
}

#pragma 1、发送消息。
- (void)sendMessageUseRunTime {
    
    NSLog(@"1、发送消息。 sendMessageUseRunTime");
    NSString * str = objc_msgSend([NSString class],sel_getUid("alloc"));
    str = objc_msgSend(str, sel_getUid("init"));
    str = objc_msgSend(str, sel_getUid("stringByAppendingString:"),@"testIt");
    NSLog(@"str == %@",str);
    
}
#pragma 2,交换方法
- (void)exchangeMethodUseRunTime {
    
    NSLog(@"2,交换方法 exchangeMethodUseRunTime");
    UIImage * image1 = [UIImage imageNamed:@"01"];
    UIImage * image2 = [UIImage imageNamed:@"0000001"];
    
    
}
#pragma 3,动态的添加方法
/*
 在OC中，只要某个方法实现了，就会被加载到类对象的方法列表中。然而有些方法不一定会用，或着极少用到，如果同样加载到方法列表中，对系统的内存会增加一些压力。这种情况下可以用Runtime让方法在真正用到时再添加。
 */
- (void)addMethodDynamically {
    
    Student * s = [[Student alloc]init];
    // 动态调用Student的实例方法sing。
    [s performSelector:@selector(sing)];
    
    // 动态调用Student的实例方法并传入两个参数。
    [s performSelector:@selector(age:height:) withObject:@20 withObject:@170];
    
}
#pragma 4,动态的添加属性
/*
 动态添加属性的本质是让某个属性和某个对象产生关联。开发中为系统的类添加属性时一般采用Runtime动态添加的方式来解决。
 */
- (void)addPropertyDynamically {
    
    UIImageView * iconView = [[UIImageView alloc]init];
    iconView.name = @"testImageView";
    NSLog(@"iconView.name == %@",iconView.name);
    
}

@end
