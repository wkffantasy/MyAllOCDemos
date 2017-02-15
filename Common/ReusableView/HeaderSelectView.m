//
//  HeaderSelectView.m
//  SmartStudy
//
//  Created by fantasy on 16/4/13.
//  Copyright © 2016年 Innobuddy Inc. All rights reserved.
//

//view
#import "HeaderSelectView.h"

//lib
#import "Masonry.h"

@interface HeaderSelectView ()

//title
@property (strong, nonatomic) NSArray * titleArray;
@property (strong, nonatomic) UIColor * titleSeletedColor;
@property (strong, nonatomic) UIColor * titleNormalColor;

//all
@property (weak, nonatomic) UIButton * selectedButton;
@property (weak, nonatomic) UIView * sepView;
@property (weak, nonatomic) UIView * moveingView;

//image
@property (strong, nonatomic) NSArray * selectedImageArray;
@property (strong, nonatomic) NSArray * normalImageArray;


@property (assign, nonatomic) CGFloat buttonW;
@end

@implementation HeaderSelectView

- (instancetype)initWithSelectedImagesArray:(NSArray *)selectedImageArray andNormalImageArray:(NSArray *)normalImageArray{
  
  if (self = [super init]) {
    
    NSAssert(normalImageArray.count == selectedImageArray.count, @"");
    
    self.selectedImageArray = selectedImageArray;
    self.normalImageArray = normalImageArray;
    
    [self setupViewsWithImage:YES];
    
  }
  return self;
  
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray andSeletedColor:(UIColor *)seletedColor andNormalColor:(UIColor *)normalColor{
  
  if (self = [super init]) {
    
    NSAssert(titleArray.count > 0, @"");
    self.titleArray = titleArray;
    self.titleNormalColor = normalColor;
    self.titleSeletedColor = seletedColor;
    [self setupViewsWithImage:NO];
    
  }
  return self;
  
}

- (void)setupViewsWithImage:(BOOL)isImage{
  
  NSArray * tempArray = isImage ? self.normalImageArray : self.titleArray;
  
  _buttonW = ScreenWidth / tempArray.count;
  
  for (int i = 0; i < tempArray.count; i++) {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = i + 100;
    
    if (isImage) {
      
      [button setImage:[UIImage imageNamed:self.normalImageArray[i]] forState:UIControlStateNormal];
      [button setImage:[UIImage imageNamed:self.selectedImageArray[i]] forState:UIControlStateSelected];
    } else {
      
      [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
      [button setTitle:self.titleArray[i] forState:UIControlStateSelected];
      [button setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
      [button setTitleColor:self.titleSeletedColor forState:UIControlStateSelected];
    }
    
    [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (i == 0) {
      button.selected = YES;
      _selectedButton = button;
    }
    
    [self addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      
      make.width.mas_equalTo(_buttonW);
      make.top.mas_equalTo(0);
      make.left.mas_equalTo(i * _buttonW);
      make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
      
    }];
    
  }
  
  UIView * sepView = [[UIView alloc]init];
  //默认分割线颜色
  sepView.backgroundColor = WKFColor(200, 200, 200, 1);
  if (self.titleNormalColor) {
    
    _sepView.backgroundColor = self.titleNormalColor;
  }
  _sepView = sepView;
  [self addSubview:sepView];
  
  [_sepView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.width.mas_equalTo(ScreenWidth);
    make.left.mas_equalTo(0);
    make.bottom.mas_equalTo(self.mas_bottom);
    make.height.mas_equalTo(1);
    
  }];
  
  UIView * moveingView = [[UIView alloc]init];
  _moveingView = moveingView;
  if (self.titleSeletedColor) {
    
    _moveingView.backgroundColor = self.titleSeletedColor;
  }
  [self addSubview:moveingView];
  [_moveingView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.centerY.mas_equalTo(self.sepView.mas_centerY);
    make.width.mas_equalTo(_buttonW);
    make.left.mas_equalTo(0);
    make.height.mas_equalTo(2);
    
  }];
  
}

- (void)setColorSepView:(UIColor *)colorSepView{
  
  _colorSepView = colorSepView;
  _sepView.backgroundColor =colorSepView;
  
}

- (void)setColorMoveing:(UIColor *)colorMoveing{
  
  _colorMoveing = colorMoveing;
  _moveingView.backgroundColor = colorMoveing;
  
}

- (void)clickbutton:(UIButton *)button{
  
  [self letItMove:button];
  
  if (self.clickButton) {
    self.clickButton((int)button.tag);
  }

}
- (void)letItMove:(UIButton *)button {
  
  int tag = (int)button.tag;
  
  _moveingView.transform = CGAffineTransformMakeTranslation((tag - 100) * _buttonW, 0);
  
  _selectedButton.selected = !_selectedButton.selected;
  
  button.selected = YES;
  _selectedButton = button;
  
  
}


- (void)updateSelectedIndex:(int)tag{
  
  for (UIButton * button in self.subviews) {
    if (button.tag == tag) {
      
      NSAssert(tag >= 100, @"");
      
      [self letItMove:button];
      break;
    
    }
  }
  
}

@end
