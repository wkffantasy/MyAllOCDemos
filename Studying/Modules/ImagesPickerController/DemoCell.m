//
//  DemoCell.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "DemoCell.h"

#define imageWH  22
#define margin 10

@implementation DemoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        CGRect imageFrame = CGRectMake(margin/2, margin/2, frame.size.width - margin, frame.size.width-margin);
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:imageFrame];
        _imageView = imageView;
        [self addSubview:imageView];
        
    }
    return self;
}

@end
