//
//  UserAccountManager.m
//  WKFAllMyDemos
//
//  Created by fantasy on 2020/6/14.
//  Copyright © 2020 fantasy. All rights reserved.
//

#import "UserAccountManager.h"

@implementation UserAccountManager

static UserAccountManager *manager = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserAccountManager alloc] init];
    });
    return manager;
}

@end
