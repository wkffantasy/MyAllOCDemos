//
//  PlayerProgressView.h
//  自定义的播放器
//
//  Created by fantasy on 16/3/17.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerProgressView : UIView

/**
 *  当前缓冲的时间  / 一共的时间
 */
@property (assign, nonatomic) CGFloat currentBufferValue;
/**
 *  当前的播放时间 / 一共的时间
 */
@property (assign, nonatomic) CGFloat currentPlayValue;


@end
