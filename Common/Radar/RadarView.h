//
//  RadarView.h
//  ieltsmobile
//
//  Created by fantasy on 16/11/17.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarView : UIView

@property (nonatomic, copy) NSString * param;

@property (nonatomic, strong) UIColor * strokeColor;
@property (nonatomic, strong) UIColor * fillColor;
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIColor * subtitleColor;

@end
