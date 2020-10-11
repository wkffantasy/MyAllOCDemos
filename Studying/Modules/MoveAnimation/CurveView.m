//
//  CurveView.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/3/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "CurveView.h"

#import "Masonry.h"

@interface CurveView ()

@property (nonatomic,assign) CGPoint beganPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat thisHeight;

@end

@implementation CurveView

- (instancetype)init{
  
  if (self = [super init]) {
    
    self.backgroundColor = [UIColor whiteColor];
    self.beganPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(ScreenWidth, 0);
    self.thisHeight = 60.0;
    
  }
  return self;
  
}

- (void)drawRect:(CGRect)rect {
  
  UIBezierPath * path = [UIBezierPath bezierPath];
  
  
  [path moveToPoint:self.beganPoint];
  
  [path addQuadCurveToPoint:self.endPoint controlPoint:CGPointMake(ScreenWidth/2, self.thisHeight)];
  
  [[UIColor redColor] setFill];
  [path fill];
  
}
- (void)updateThisHeight:(CGFloat)thisHeight {
  
  self.thisHeight = thisHeight;
  [self layoutIfNeeded];
  
}


@end
