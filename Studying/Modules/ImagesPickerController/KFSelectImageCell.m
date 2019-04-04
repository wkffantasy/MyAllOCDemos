//
//  KFSelectImageCell.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "KFSelectImageCell.h"

#define imageWH  22
#define margin 10

@interface KFSelectImageCell ()

@property (nonatomic,weak) UIImageView * imageView;
@property (nonatomic,weak) UIImageView * statusImageView;

@end
@implementation KFSelectImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        CGRect imageFrame = CGRectMake(margin/2, margin/2, frame.size.width - margin, frame.size.width-margin);
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:imageFrame];
        _imageView = imageView;
        [self addSubview:imageView];
        
        UIImageView * statusView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - imageWH-margin/2, margin/2, imageWH, imageWH)];
        statusView.image = [UIImage imageNamed:@"ic-select-green"];
        _statusImageView = statusView;
        [self addSubview:statusView];
        
    }
    return self;
}

- (void)setAsset:(KFAsset *)asset {
    _asset = asset;
    _imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
    _statusImageView.hidden = !asset.selected;
    
}

@end
