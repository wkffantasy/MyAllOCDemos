//
//  WaveView.h
//  WKFAllMyDemos
//
//  Created by fantasy on 17/2/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

/**
 初始化View
 
 @param frame frame
 @param backgroundColor 背景颜色
 @param fillColor 填充颜色
 @param autoPlay 是否自动播放
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    fillColor:(UIColor *)fillColor
                     autoPlay:(BOOL)autoPlay;

/**
 *  开始动画
 */
- (void)startWaveAnimation;

/**
 *  暂停动画，继续动画时不会归零offsetX
 */
- (void)pauseWaveAnimation;

/**
 *  移除动画，下次开始动画时将归零offsetX
 */
- (void)removeWaveAnimation;

@end
