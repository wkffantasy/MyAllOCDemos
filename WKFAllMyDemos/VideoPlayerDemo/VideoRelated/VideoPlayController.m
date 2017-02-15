//
//  VideoPlayController.m
//  自定义的播放器
//
//  Created by fantasy on 16/3/15.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "VideoPlayController.h"
#import <AVFoundation/AVFoundation.h>

#import "TimeTool.h"
#import "PlayerProgressView.h"
#import "Masonry.h"

#import "Reachability.h"

#define topAndBottomHeight 44

@interface VideoPlayController ()

@property (weak, nonatomic) UIView * bottomView;

@property (weak, nonatomic) UIView * videoPlayerView;
@property (strong, nonatomic) AVPlayer * videoPlayer;
@property (strong, nonatomic) AVPlayerItem * playerItem;
@property (strong, nonatomic) AVPlayerLayer * playerLayer;

@property (weak, nonatomic) UIView * coverView;
@property (weak, nonatomic) UIView * volumeView;

@property (assign, nonatomic) VideoPlayerScreenStatus screenStatus;


@property (assign, nonatomic) BOOL isPause;
@property (assign, nonatomic) BOOL isFull;
@property (assign, nonatomic) BOOL isSeeking;//是否在快进快退

@property (weak, nonatomic) UIButton * pauseButton;
@property (weak, nonatomic) UILabel * totalTimeLabel;
@property (weak, nonatomic) UILabel * currentTimeLabel;
@property (weak, nonatomic) UIButton * backButton;
@property (strong, nonatomic) id timeObserver;


@property (strong, nonatomic) NSArray * ratesArray;
@property (assign, nonatomic) int ratesIndex;

@property (copy, nonatomic) NSString * totalTime;
@property (copy, nonatomic) NSString * currentTime;

@property (weak, nonatomic) PlayerProgressView * progressView;

@property (assign, nonatomic) CGRect fullScreenFrame;
@property (assign, nonatomic) CGRect smallScreenFrame;

@end


@implementation VideoPlayController

- (void)dealloc{
  
  [self.videoPlayer pause];
  [self.videoPlayer.currentItem removeObserver:self forKeyPath:@"status"];
  [self.videoPlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
  
  self.videoPlayer = nil;
  
}

- (instancetype)initWithVideoPlayerScreenStatus:(VideoPlayerScreenStatus)screenStatus andPlayUrl:(NSString *)url{
  
  if (self = [super init]) {
    
    _screenStatus = screenStatus;
    _playUrl = url;
    
  }
  return self;
  
}

- (instancetype)init{
  
  if (self = [super init]) {
    
    
    
  }
  return self;
  
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self othersPropertySettings];
  
  [self setupVideoPlayer];
  
  [self setupBottomView];
  
}

- (void)othersPropertySettings{
  
  self.view.backgroundColor = [UIColor whiteColor];
 
  _ratesArray = @[@"1.0",@"1.5",@"2.0"];
  _ratesIndex = 0;
  
  _smallScreenFrame = CGRectMake(0, 20, ScreenWidth, ScreenWidth * 0.6);
  
  _fullScreenFrame = CGRectMake(0, 0, ScreenHeight, ScreenWidth);
  
  switch (_screenStatus) {
    case VideoPlayerScreenFull:
      self.isFull = YES;
      break;
    case VideoPlayerScreenSmall:
      self.isFull = NO;
      break;
    default:
      self.isFull = NO;
      break;
  }
  
}

- (void)setupVideoPlayer{
  
  UIView * playerView = [[UIView alloc]init];
  _videoPlayerView = playerView;
  [self.view addSubview:playerView];
  
  switch (_screenStatus) {
    case VideoPlayerScreenFull:{
      
      _videoPlayerView.frame = _fullScreenFrame;
      
    }
      break;
    case VideoPlayerScreenSmall:{
      
      _videoPlayerView.frame = _smallScreenFrame;
      
    }
      break;
    default:{
      _videoPlayerView.frame = _smallScreenFrame;;
    }
      
      break;
  }
  
  self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.playUrl]];
  
  NSAssert(self.playerItem, @"player item cannot be nil");
  
  AVPlayer * player = [AVPlayer playerWithPlayerItem:self.playerItem];
  player.volume = 0.5f;
  NSAssert(player, @"player cannot be nil");
  
  if (player) {
    
    self.videoPlayer = player;
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPlayer];
    
    _playerLayer.backgroundColor = [UIColor redColor].CGColor;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _playerLayer.frame = playerView.layer.bounds;
    
    [playerView.layer addSublayer:_playerLayer];
    
    //快进快退的view
    UIView * coverView = [[UIView alloc]init];
    coverView.userInteractionEnabled = NO;
    coverView.backgroundColor = [UIColor clearColor];
    _coverView = coverView;
    coverView.frame = playerView.bounds;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView:)];
    [coverView addGestureRecognizer:tap];
    [playerView addSubview:coverView];
    UIPanGestureRecognizer * progressPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_coverView addGestureRecognizer:progressPan];
    
    //音量的view
    UIView * volume = [[UIView alloc]init];
    volume.userInteractionEnabled = NO;
    volume.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer * volumePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [volume addGestureRecognizer:volumePan];
    [playerView addSubview:volume];
    UITapGestureRecognizer * volumeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView:)];
    [volume addGestureRecognizer:volumeTap];
    _volumeView = volume;
    
    [volume mas_makeConstraints:^(MASConstraintMaker *make) {
      
      make.top.mas_equalTo(0);
      make.right.mas_equalTo(0);
      make.bottom.mas_equalTo(0);
      make.width.mas_equalTo(100);
      
    }];
    
    //刚刚开始 获取当前视频的长度
    [self.videoPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //获取当前视频的缓冲进度
    [self.videoPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.videoPlayer play];
    
  }
  
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
 
  BOOL canPlay = [self checkNetwork];
  if (!canPlay) {
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"非wifi环境不能播放" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertC)weakAlert = alertC;
    [alertC addAction:[UIAlertAction actionWithTitle:@" 确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      
      [weakAlert dismissViewControllerAnimated:YES completion:nil];
      
    }]];
    
    [self.videoPlayer pause];
    [self presentViewController:alertC animated:YES completion:nil];
    
    return;
    
  }

  
  if (object == self.videoPlayer.currentItem ) {
    
    AVPlayerItem * playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
      
      AVPlayerStatus status = [change[@"new"] integerValue];
      switch (status) {
        case AVPlayerStatusUnknown:{
          
        }
          break;
        case AVPlayerStatusReadyToPlay:{
          
          //加载完成之后 才能快进快退  滑动控制声音
          _coverView.userInteractionEnabled = YES;
          _volumeView.userInteractionEnabled = YES;
          
          if (self.buttonStatus) {
            self.buttonStatus(VideoPlayerStatusPlaying);
          }
          //总时间
          CMTime totalTime = playerItem.duration;
          int totalTimeInt =(int)totalTime.value / totalTime.timescale;
          self.totalTime = [TimeTool TimeSecondConvertToString:totalTimeInt];
          self.totalTimeLabel.text = [NSString stringWithFormat:@"/%@",self.totalTime];
          
          [self setupProgressViewWithMaxValue:(CGFloat)totalTimeInt];
          //当前时间
          @weakify(self);
         
          self.timeObserver = [self.videoPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
            @strongify(self);
            CGFloat currentTime = (CGFloat)self.playerItem.currentTime.value / self.playerItem.currentTime.timescale;
            
            self.progressView.currentPlayValue = currentTime / (totalTime.value / totalTime.timescale);
            self.currentTime = [TimeTool TimeSecondConvertToString:currentTime];
            self.currentTimeLabel.text = self.currentTime;
            
          }];
          
          
        }
          break;
        case AVPlayerStatusFailed:{
          
          if (self.buttonStatus) {
            self.buttonStatus(VideoPlayerStatusFailed);
          }
          
        }
          break;
          
        default:
          break;
      }
      
      
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
      
      NSArray * loadedTimeRanges = self.playerItem.loadedTimeRanges;
      CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
      
      float  durationSeconds = CMTimeGetSeconds(timeRange.duration);
      float  startSeconds = CMTimeGetSeconds(timeRange.start);
      
      CMTime totalTime = playerItem.duration;
      
      self.progressView.currentBufferValue = (durationSeconds+startSeconds) / (totalTime.value / totalTime.timescale);
      
    }
    
  }
  
}
- (void)removePlayerTimeOberver{
  
  if (self.timeObserver) {
    [self.videoPlayer removeTimeObserver:self.timeObserver];
    self.timeObserver = nil;
  }
  
}

- (void)setupBottomView{
  
  UIView * bottomView = [[UIView alloc]init];
  bottomView.backgroundColor = [UIColor blackColor];
  bottomView.alpha = 0.8;
  _bottomView = bottomView;
  [_videoPlayerView addSubview:bottomView];
  
  self.isPause = NO;
  UIButton * pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
  [pauseButton addTarget:self action:@selector(clickPauseButton:) forControlEvents:UIControlEventTouchUpInside];
  _pauseButton = pauseButton;
  [self buttonSetFont:pauseButton];
  [bottomView addSubview:pauseButton];
  
  
  UILabel * timeLabel = [[UILabel alloc]init];
  timeLabel.font = [UIFont systemFontOfSize:14];
  timeLabel.textColor = [UIColor whiteColor];
  timeLabel.text = @"00:00:00";
  timeLabel.textAlignment = NSTextAlignmentRight;
  [timeLabel sizeToFit];
  _currentTimeLabel= timeLabel;
  [bottomView addSubview:timeLabel];
  
  UILabel * totalTimeLabel = [[UILabel alloc]init];
  totalTimeLabel.font = [UIFont systemFontOfSize:14];
  totalTimeLabel.textColor = [UIColor whiteColor];
  totalTimeLabel.text = @"/00:00:00";
  totalTimeLabel.textAlignment = NSTextAlignmentLeft;
  [totalTimeLabel sizeToFit];
  _totalTimeLabel = totalTimeLabel;
  [bottomView addSubview:totalTimeLabel];
  
  UIButton * fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [fullButton addTarget:self action:@selector(clickFullButton:) forControlEvents:UIControlEventTouchUpInside];
  [self buttonSetFont:fullButton];
  if (self.isFull) {
    [fullButton setTitle:@"小屏" forState:UIControlStateNormal];
  } else {
    [fullButton setTitle:@"全屏" forState:UIControlStateNormal];
  }

  [bottomView addSubview:fullButton];
  
  
  UIButton * rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [rateButton setTitle:[self titleStringFromRateArray] forState:UIControlStateNormal];
  [rateButton addTarget:self action:@selector(clickRateButton:) forControlEvents:UIControlEventTouchUpInside];
  [self buttonSetFont:rateButton];
  [bottomView addSubview:rateButton];
  
  UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [backButton setTitle:@"返回" forState:UIControlStateNormal];
  [backButton sizeToFit];
  [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
  backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    backButton.backgroundColor = WKFColor(0, 0, 0, 0.5);
  backButton.layer.masksToBounds = YES;
  backButton.layer.cornerRadius = (backButton.width)/2;
  _backButton = backButton;
  [self buttonSetFont:backButton];
  [_videoPlayerView addSubview:backButton];
  
  
  [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.bottom.mas_equalTo(self.videoPlayerView.mas_bottom);
    make.left.mas_equalTo(0);
    make.right.mas_equalTo(0);
    make.height.mas_equalTo(topAndBottomHeight);
    
  }];
  
  [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.mas_equalTo(20);
    make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    make.height.and.width.mas_equalTo(topAndBottomHeight);
    
  }];
  
  [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.mas_equalTo(pauseButton.mas_right).offset(20);
    make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    make.height.mas_equalTo(topAndBottomHeight);
    make.width.mas_equalTo(timeLabel.frame.size.width);
    
  }];
  
  [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.mas_equalTo(timeLabel.mas_right);
    make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    make.height.mas_equalTo(topAndBottomHeight);
    make.width.mas_equalTo(totalTimeLabel.frame.size.width);
    
  }];
  
  [fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.width.and.height.mas_equalTo(topAndBottomHeight);
    make.right.mas_equalTo(-20);
    make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    
  }];
  
  [rateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.right.mas_equalTo(fullButton.mas_left).offset(-20);
    make.height.and.width.mas_equalTo(topAndBottomHeight);
    make.centerY.mas_equalTo(fullButton.mas_centerY);
    
  }];
  
  [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(20);
    make.top.mas_equalTo(20);
    make.height.and.width.mas_equalTo(backButton.width);
    
  }];
  
}

- (void)setupProgressViewWithMaxValue:(CGFloat)value{
  
  PlayerProgressView * progressView = [[PlayerProgressView alloc]init];
  _progressView = progressView;
  [self.bottomView addSubview:progressView];
  
  [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.height.mas_equalTo(3);
    make.left.mas_equalTo(0);
    make.right.mas_equalTo(0);
    make.top.mas_equalTo(self.bottomView.mas_top);
    
  }];
  
}

- (NSString *)titleStringFromRateArray{
  
  if (_ratesIndex > _ratesArray.count-1) {
    _ratesIndex = 0;
  }
  NSString * ret = [NSString stringWithFormat:@"x %@",_ratesArray[_ratesIndex]];
  return ret;
  
}

#pragma mark - click button selectors
- (void)tapCoverView:(UITapGestureRecognizer *)tap{
  
  self.bottomView.hidden = !self.bottomView.hidden;
  self.backButton.hidden = !self.backButton.hidden;
  
}
- (void)pan:(UIPanGestureRecognizer * )pan{
  
  if (pan.view == self.volumeView) {//声音大小
    [self didPanGesture:pan isVolume:YES];
    
  } else if (pan.view == self.coverView) {//快进快退
    [self didPanGesture:pan isVolume:NO];
    
  } else {
    
  }
  
}
- (void)didPanGesture:(UIPanGestureRecognizer *)pan isVolume:(BOOL)isVolume{
  
  switch (pan.state) {
    case UIGestureRecognizerStateBegan:{
      if (!isVolume) {
        self.volumeView.hidden = YES;
        [self updatePlayingProgress:[pan translationInView:pan.view]];
      } else {
        [self updateVolume:[pan translationInView:pan.view]];
      }
      
    }
      break;
    case UIGestureRecognizerStateChanged:{
      if (isVolume) {
        [self updateVolume:[pan translationInView:pan.view]];
      } else {
        [self updatePlayingProgress:[pan translationInView:pan.view]];
      }
      
    }
      break;
    case UIGestureRecognizerStateEnded:{
      
      if (!isVolume) {
        self.volumeView.hidden = NO;
      } else {
        
      }
      
    }
      break;
    case UIGestureRecognizerStateCancelled:{
      
      if (!isVolume) {
        self.volumeView.hidden = NO;
      } else {
      }
      
    }
      break;
    case UIGestureRecognizerStateFailed:{
      
      if (!isVolume) {
        self.volumeView.hidden = NO;
      } else {
        
      }
    }
      break;
      
    default:
      break;
  }
  
  [pan setTranslation:CGPointZero inView:pan.view];
  
}
//滑动快进快退
- (void)updatePlayingProgress:(CGPoint)progressPoint{
  
  if (!self.progressView) {
    return;
  }
  CGFloat changeProgressX = progressPoint.x / self.videoPlayerView.frame.size.width ;
  NSLog(@"changeProgressX==%f progressPoint.x==%f",changeProgressX,progressPoint.x);
  self.progressView.currentPlayValue +=  changeProgressX;
  CGFloat currentTime = self.progressView.currentPlayValue * self.videoPlayerView.frame.size.width;
  self.currentTime = [TimeTool TimeSecondConvertToString:currentTime];
  self.currentTimeLabel.text = self.currentTime;
//  if (!self.isSeeking) {
//    self.isSeeking = YES;
  @weakify(self);
    [self.videoPlayer seekToTime:CMTimeMake(self.progressView.currentPlayValue * self.totalTime.floatValue, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
      @strongify(self);
      self.isSeeking = NO;
      
    }];
//  }
  
}

//滑动声音大小
- (void)updateVolume:(CGPoint)changePoint{
  
  self.videoPlayer.volume += (-changePoint.y) / self.videoPlayerView.frame.size.height;
  NSLog(@"volume %f",self.videoPlayer.volume);
  if (self.videoPlayer.volume > 1) {
    self.videoPlayer.volume = 1;
  } else if (self.videoPlayer.volume < 0){
    
    self.videoPlayer.volume = 0;
    
  }
  
}

- (void)clickRateButton:(UIButton *)button{
  
  _ratesIndex++;
  [button setTitle:[self titleStringFromRateArray] forState:UIControlStateNormal];
  if (self.buttonRate) {
    self.buttonRate([self titleStringFromRateArray]);
  }
  CGFloat rate = [_ratesArray[_ratesIndex] floatValue];
  self.videoPlayer.rate = rate;
  
  if (self.isPause) {
    
    [self.pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    self.isPause = !self.isPause;
  }
  
}


- (void)clickFullButton:(UIButton *)button{
  
  self.isFull = !self.isFull;
  
  if (self.isFull) {
    
    [button setTitle:@"小屏" forState:UIControlStateNormal];
    if (self.buttonFullScreen) {
      self.buttonFullScreen(VideoPlayerScreenFull);
    }
    _videoPlayerView.frame = _fullScreenFrame;
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
      
      make.height.mas_equalTo(50);
      make.bottom.mas_equalTo(self.videoPlayerView.mas_bottom);
      make.left.mas_equalTo(0);
      make.right.mas_equalTo(0);
      
    }];
    [UIView animateWithDuration:0.2 animations:^{
      
      self.view.frame = CGRectMake(0, 0, ScreenWidth ,ScreenHeight );
      
    }];
    
  } else {
    
    
    [button setTitle:@"全屏" forState:UIControlStateNormal];
    if (self.buttonFullScreen) {
      self.buttonFullScreen(VideoPlayerScreenSmall);
    }
    _videoPlayerView.frame = _smallScreenFrame;
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
      
      make.height.mas_equalTo(topAndBottomHeight);
      make.bottom.mas_equalTo(self.videoPlayerView.mas_bottom);
      make.left.mas_equalTo(0);
      make.right.mas_equalTo(0);
      
    }];
    [UIView animateWithDuration:0.2 animations:^{
      
      self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
      
    }];
    
  }
  [self statusBarChange:self.isFull];
  _coverView.frame = self.videoPlayerView.bounds;
  _playerLayer.frame = _videoPlayerView.bounds;
  
}

- (void)statusBarChange:(BOOL )isFull{
  
  if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val ;
    if (isFull) {
      
      [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
      val = UIInterfaceOrientationLandscapeRight;
      
    } else {
      [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
      val = UIInterfaceOrientationPortrait;
    }
    
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
  }
  
}

- (void)clickPauseButton:(UIButton *)button{
  
  if (self.isPause) {
    [button setTitle:@"暂停" forState:UIControlStateNormal];
    [self.videoPlayer play];
    if (self.buttonStatus) {
      self.buttonStatus(VideoPlayerStatusPlaying);
    }
  } else {
    [button setTitle:@"继续" forState:UIControlStateNormal];
    [self.videoPlayer pause];
    if (self.buttonStatus) {
      self.buttonStatus(VideoPlayerStatusPaused);
    }
  }
  
  self.isPause = !self.isPause;
  
}

- (void)clickBackButton:(UIButton *)button{
  
  self.videoPlayer.rate = 0.0;
  
  if (self.buttonBack) {
    self.buttonBack();
  }
  
  
}
- (void)buttonSetFont:(UIButton *)button{
  
  button.titleLabel.font = [UIFont systemFontOfSize:13];
  
}

/**
 *  只有在wifi的情况下才能播放
 */
- (BOOL)checkNetwork{
  
  Reachability * reach = [Reachability reachabilityForLocalWiFi];
  switch ([reach currentReachabilityStatus]) {
    
    case ReachableViaWiFi:
      return YES;
      break;
      
    default:
      return NO;
      break;
  }
  
  return NO;
  
}


@end
