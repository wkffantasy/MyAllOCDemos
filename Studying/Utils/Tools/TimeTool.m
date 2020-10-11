//
//  TimeTool.m
//  自定义的播放器
//
//  Created by fantasy on 16/3/17.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool



+ (NSString *)TimeSecondConvertToString:(int)second{
  
  NSString * realTime = nil;
  int hour = second / 3600;
  int newTime = second % 3600;
  int minite = newTime / 60;
  int newSecond = newTime % 60;
  realTime = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minite,newSecond];
  return realTime;
  
}

@end
