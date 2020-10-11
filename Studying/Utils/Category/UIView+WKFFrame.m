//
//  UIView+WKFFrame.m
//  
//
//  Created by fantasy on 15/4/2.
//  Copyright (c) 2015年 fantasy. All rights reserved.
//

#import "UIView+WKFFrame.h"

@implementation UIView (WKFFrame)


- (void)setWidth:(CGFloat)width{
  
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
  
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
  
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
  
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x{
  
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
  
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
  
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
  
    return self.frame.origin.y;
}


-(void)makeCornerRadius:(float)radius borderColor:(UIColor *)bColor borderWidth:(float)bWidth{
    self.layer.borderWidth = bWidth;
    
    if (bColor != nil) {
        self.layer.borderColor = bColor.CGColor;
    }
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
@end
