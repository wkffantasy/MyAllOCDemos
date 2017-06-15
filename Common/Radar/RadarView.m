//
//  RadarView.m
//  ieltsmobile
//
//  Created by fantasy on 16/11/17.
//  Copyright © 2016年 Facebook. All rights reserved.
//
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBCOLOR(h) RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBACOLOR(h,a) RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)

#import "RadarView.h"
#import "MCRadarChartView.h"

@interface RadarView()<MCRadarChartViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) MCRadarChartView *radarChartView;

@end

@implementation RadarView

- (instancetype)init{
  
  if (self = [super init]) {
    
  }
  
  return self;
  
}

- (void)setParam:(NSString *)param{
  
  _param = param;
  [_radarChartView removeFromSuperview];
  _radarChartView = nil;

  /*
   param== {"titleArray":["阅读测评","口语测评","写作测评","听力测评"],"valuesArray":["40","20","60","80"],"radius":100,"pointRadius":2}
   */
  
  NSError *error = nil;
  NSDictionary * paramDict = [NSJSONSerialization JSONObjectWithData:[param dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
  
  _titles = paramDict[@"titleArray"];
  _values = paramDict[@"valuesArray"];
  
  _radarChartView = [[MCRadarChartView alloc] init];
  _radarChartView = [[MCRadarChartView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
  
  _radarChartView.dataSource = self;
  _radarChartView.radius = [paramDict[@"radius"] intValue];
  _radarChartView.pointRadius = [paramDict[@"pointRadius"] intValue];
  
  _radarChartView.strokeColor = [UIColor colorWithRed:0/255.0 green:207/255.0 blue:187/255.0 alpha:1.0];
  _radarChartView.fillColor = [UIColor colorWithRed:0/255.0 green:207/255.0 blue:187/255.0 alpha:0.2];
  [self addSubview:_radarChartView];
  [self layoutSubviews];
  
}

- (void)setStrokeColor:(UIColor *)strokeColor{
  
  _strokeColor = strokeColor;
  _radarChartView.strokeColor = strokeColor;
  [_radarChartView setNeedsLayout];
  
}
- (void)setFillColor:(UIColor *)fillColor{
  _fillColor = fillColor;
  _radarChartView.fillColor = fillColor;
  [_radarChartView setNeedsLayout];
}
- (void)setTitleColor:(UIColor *)titleColor{
  
  _titleColor = titleColor;
  [self setNeedsLayout];
  
}
- (void)setSubtitleColor:(UIColor *)subtitleColor{
  _subtitleColor = subtitleColor;
  [self setNeedsLayout];
}

- (NSInteger)numberOfValueInRadarChartView:(MCRadarChartView *)radarChartView {
  return _titles.count;
}

- (id)radarChartView:(MCRadarChartView *)radarChartView valueAtIndex:(NSInteger)index {
  
  return @([_values[index] floatValue]/100.0);
}

- (NSString *)radarChartView:(MCRadarChartView *)radarChartView titleAtIndex:(NSInteger)index {
  return _titles[index];
}

- (NSAttributedString *)radarChartView:(MCRadarChartView *)radarChartView attributedTitleAtIndex:(NSInteger)index {
  
  NSString * title = _titles[index];
  NSString * score = [NSString stringWithFormat:@"%@分",_values[index]];
  NSString * retString = [NSString stringWithFormat:@"%@\n%@",title,score];
  NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:retString];
  //字体
  [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, attString.length)];
  //颜色
  [attString addAttribute:NSForegroundColorAttributeName value:_titleColor ? : HEXRGBCOLOR(0xfe663b) range:NSMakeRange(0, title.length)];
  [attString addAttribute:NSForegroundColorAttributeName value:_subtitleColor ? : HEXRGBCOLOR(0xffffff) range:NSMakeRange(title.length, score.length+1)];
  
  return attString;
  
}





@end
