//
//  VideoPlayController.h
//  自定义的播放器
//
//  Created by fantasy on 16/3/15.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,VideoPlayerStatus){
  
  VideoPlayerStatusPlaying = 0,
  VideoPlayerStatusPaused,
  VideoPlayerStatusStopped,
  VideoPlayerStatusFailed,
};

typedef NS_ENUM(NSUInteger,VideoPlayerScreenStatus){

  VideoPlayerScreenSmall = 0,
  VideoPlayerScreenFull,
  
} ;

//WhenClickBack
typedef void(^ClickBackButton)();

//When click rate button
typedef void(^ClickRateButton)(NSString * rate);

//When click pause or play
typedef void(^ClickChangePlayStatusButton)(VideoPlayerStatus status);

//When click fullScreen button
typedef void(^ClickFullScreenOrNotButton)(VideoPlayerScreenStatus screenStatus);

@interface VideoPlayController : UIViewController

@property (copy, nonatomic) NSString * playUrl;
@property (copy, nonatomic) ClickBackButton             buttonBack;
@property (copy, nonatomic) ClickRateButton             buttonRate;
@property (copy, nonatomic) ClickChangePlayStatusButton buttonStatus;
@property (copy, nonatomic) ClickFullScreenOrNotButton  buttonFullScreen;

- (instancetype)initWithVideoPlayerScreenStatus:(VideoPlayerScreenStatus)screenStatus andPlayUrl:(NSString *)url;

@end
