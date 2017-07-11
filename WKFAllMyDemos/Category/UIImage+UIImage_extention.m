//
//  UIImage+UIImage_extention.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/26.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "UIImage+UIImage_extention.h"
#import <objc/message.h>

@implementation UIImage (UIImage_extention)

// 只要此类被项目引用，程序启动时就会调用这个方法
+ (void)load {
    
    // 这个函数用来获取类的方法。第一个参数：获取哪个类的方法。第二个参数：获取哪个方法。
    Method imageNamed = class_getClassMethod(self, sel_getUid("imageNamed:"));
    Method imageWithName = class_getClassMethod(self, sel_getUid("imageWithName:"));
    
    // 交换两个方法的实现部分。
    // 即调用imageNamed就会执行hl_imageNamed的实现，调用hl_imageNamed就会执行imageNamed的实现。
    method_exchangeImplementations(imageNamed, imageWithName);
    
}

// 一个带有扩展系统功能的方法实现。
+ (UIImage *)imageWithName:(NSString *)name {
    // 此时会调用imageNamed的系统实现部分，因为实现部分已经做了交换。
    
    NSLog(@"imageWithName name == %@",name);
    UIImage * image = [self imageWithName:name];
    if (image) {
        NSLog(@"图片加载成功");
    } else {
        NSLog(@"图片加载失败");
    }
    return image;
    
}


@end
