//
//  PlayerProgressView.m
//  自定义的播放器
//
//  Created by fantasy on 16/3/17.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PlayerProgressView.h"

@interface PlayerProgressView ()

@property (weak, nonatomic) UIView * playProgressView;
@property (weak, nonatomic) UIView * bufferProgressView;

@end

@implementation PlayerProgressView

- (instancetype)initWithFrame:(CGRect)frame{
  
  if (self = [super initWithFrame:frame]) {
    
    self.backgroundColor = [UIColor clearColor];
    [self setupChildViews];
  }
  return self;
  
}

- (void)setupChildViews{
  
  UIView * bufferProgressView = [[UIView alloc]init];
  //缓冲的颜色
  bufferProgressView.backgroundColor = [UIColor redColor];
  bufferProgressView.layer.masksToBounds = YES;
  _bufferProgressView = bufferProgressView;
  [self addSubview:bufferProgressView];
  
  UIView * playProgressView = [[UIView alloc]init];
  //播放进度的颜色
  playProgressView.backgroundColor = [UIColor whiteColor];
  playProgressView.layer.masksToBounds = YES;
  _playProgressView = playProgressView;
  [self addSubview:playProgressView];
  
}

- (void)setCurrentBufferValue:(CGFloat)currentBufferValue{
  
  if (currentBufferValue < 0) {
    
    return;
  }
  _currentBufferValue = currentBufferValue;
  
  [self layoutSubviews];
}

- (void)setCurrentPlayValue:(CGFloat)currentPlayValue{
  
  if (currentPlayValue < 0) {
    return;
  }
  _currentPlayValue = currentPlayValue;
  [self layoutSubviews];
  
}

- (void)layoutSubviews{
  
  [super layoutSubviews];
  
  CGFloat bufferWidth = _currentBufferValue * self.frame.size.width;
  CGFloat playWidth = _currentPlayValue * self.frame.size.width;
  
  CGFloat cornerRadius = self.frame.size.height / 2;
  
  _bufferProgressView.frame = CGRectMake(0, 0, bufferWidth, self.frame.size.height);
  _playProgressView.frame = CGRectMake(0, 0, playWidth, self.frame.size.height);
  
  _bufferProgressView.layer.cornerRadius = cornerRadius;
  _playProgressView.layer.cornerRadius = cornerRadius;
  
}

@end
