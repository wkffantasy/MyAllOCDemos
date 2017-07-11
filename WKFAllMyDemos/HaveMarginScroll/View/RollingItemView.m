//
//  RollingItemView.m
//  循环滚动
//
//  Created by fantasy on 16/8/25.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "RollingItemView.h"

#import "Masonry.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBCOLOR(h) RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBACOLOR(h,a) RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)

@interface RollingItemView ()

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * detail;
@property (copy, nonatomic) NSString * imageName;

@end

@implementation RollingItemView

- (instancetype)initWithTitle:(NSString *)title andDetailTitle:(NSString *)detail andImageName:(NSString *)imageName{
  
  if (self = [super init]) {
    
    NSAssert(title.length > 0, @"");
    NSAssert(detail.length > 0, @"");
    NSAssert(imageName.length > 0, @"");
    
    self.title = title;
    self.detail = detail;
    self.imageName = imageName;
    
    [self setupViews];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
  }
  return self;
  
}
- (void)setupViews{
  
  UILabel * labelTitle = [UILabel new];
  labelTitle.font = [UIFont systemFontOfSize:22];
  labelTitle.text = self.title;
  labelTitle.textColor = HEXRGBCOLOR(0x454545);
  [self addSubview:labelTitle];
  [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.top.mas_equalTo(10);
    make.centerX.mas_equalTo(self.mas_centerX);
    
  }];
  
  UILabel * labelDetail = [UILabel new];
  labelDetail.font = [UIFont systemFontOfSize:15];
  labelDetail.textColor = HEXRGBCOLOR(0x666666);
  labelDetail.text = self.detail;
  [self addSubview:labelDetail];
  [labelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.centerX.mas_equalTo(self.mas_centerX);
    make.top.mas_equalTo(labelTitle.mas_bottom).offset(25);
    
  }];
  
  UIImageView * imageView = [UIImageView new];
  imageView.image = [UIImage imageNamed:self.imageName];
  [self addSubview:imageView];
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.and.right.and.bottom.mas_equalTo(0);
    make.top.mas_equalTo(labelDetail.mas_bottom).offset(25);
    make.height.mas_equalTo(200);
    
  }];
  
  
  
}



@end
