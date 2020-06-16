//
//  TestRetainCircleView.m
//  WKFAllMyDemos
//
//  Created by fantasy on 2020/6/14.
//  Copyright © 2020 fantasy. All rights reserved.
//

#import "TestRetainCircleView.h"

@implementation TestRetainCircleView

- (instancetype)init {
    if (self = [super init]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.didClickBlock) {
        self.didClickBlock();
    }
}

@end
