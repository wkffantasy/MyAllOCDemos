//
//  WaveView.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/2/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "WaveView.h"

#define waveAmplitude  (self.frame.size.height / 2)
#define waveCycle      (1.1 * M_PI / ([UIScreen mainScreen].bounds.size.width / 3.0))

@interface WaveView ()

@property (nonatomic, strong) CAShapeLayer  *firstLayer;
@property (nonatomic, strong) CAShapeLayer  *secondLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic,assign) CGFloat waveOffsetX;

@end


@implementation WaveView


- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      
      self.clipsToBounds = YES;
      self.waveOffsetX = 0;
      
      self.firstLayer = [CAShapeLayer layer];
      self.firstLayer.fillColor = HEXRGBCOLOR(0xff8900).CGColor;
      [self.layer addSublayer:self.firstLayer];
      
      self.secondLayer = [CAShapeLayer layer];
      self.secondLayer.fillColor = [UIColor redColor].CGColor;
      [self.layer addSublayer:self.secondLayer];
      
      self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
      [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
      
  }
  return self;
}

- (void)removeThisDisplayLink{
    
    [self.displayLink invalidate];
    
}
- (void)getCurrentWave{
    
    self.waveOffsetX += 0.02;
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = 0;
    CGPathMoveToPoint(path, nil, 0, y);

    for (int x = 0; x<=self.frame.size.width; x++) {
        y = waveAmplitude - waveAmplitude * sin(waveCycle * x + self.waveOffsetX);
        CGPathMoveToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.firstLayer.path = path;
    CGPathRelease(path);
    
    
//    for (int index = 0; index<2; index++) {
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGFloat y = 0;
//        CGPathMoveToPoint(path, nil, 0, y);
//        for (CGFloat x = 0.0; x<=self.frame.size.width; x++) {
//            y = waveAmplitude - waveAmplitude * sin((waveCycle * x+index*M_PI)+self.waveOffsetX);
//            CGPathMoveToPoint(path, nil, x, y);
//        }
//        CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
//        CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
//        CGPathCloseSubpath(path);
//        if (index == 0) {
//            self.secondLayer.path = path;
//        } else {
//            self.firstLayer.path = path;
//        }
//        CGPathRelease(path);
//    }
    
    
}


@end
