//
//  UIImageView+testExtension.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/26.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "UIImageView+testExtension.h"

#import <objc/message.h>

@implementation UIImageView (testExtension)

- (void)setName:(NSString *)name {
    
    NSLog(@"UIImageView (testExtension) name ==%@",name);
    // id object：给哪个对象添加属性。
    // const void *key：属性名称。
    // id value：属性值。
    // objc_AssociationPolicy policy：属性的保存策略，是一个枚举，相当于assign、retain、copy等。
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, @"name");
}

@end
