//
//  Student.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/26.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "Student.h"

#import <objc/message.h>

@implementation Student

// 函数不会放入方法列表，系统默认传递的隐式参数id self(当前类对象或者实例对象)和SEL _cmd(当前方法的编号)。
void sing(id self,SEL sel) {
    NSLog(@"唱歌的方法 sel == %@",NSStringFromSelector(sel));
}
void ageAndHeight(id self,SEL sel ,NSNumber *age,NSNumber *height) {
    NSLog(@"年龄是：%@,身高是：%@",age,height);
}

//只要调用了一个未实现的方法，就会调用这个方法进行处理。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"sel ==%@",NSStringFromSelector(sel));
    if (sel == NSSelectorFromString(@"sing")) {
        
        class_addMethod(self, sel, (IMP)sing, "v@:");
    } else if (sel == NSSelectorFromString(@"age:height:")) {
        class_addMethod(self, sel, (IMP)ageAndHeight, "v@:@@");
    }
    return [super resolveClassMethod:sel];
}
@end
