//
//  VideoRecordController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/7/19.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "VideoRecordController.h"

#import <AVFoundation/AVFoundation.h>

@interface VideoRecordController ()


@property (weak, nonatomic) UIView * userCamera;

//负责输入和输出设置之间的数据传递
@property (strong, nonatomic) AVCaptureSession * captureSession;
//负责从AVCaptureDevice获得输入数据
@property (strong, nonatomic) AVCaptureDeviceInput * captureDeviceInput;
//视频输出流
@property (strong, nonatomic) AVCaptureMovieFileOutput * captureMovieFileOutput;
//相机拍摄预览图层
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * captrueVideoPreviewLayer;

@end

@implementation VideoRecordController

- (instancetype)init {
    if (self = [super init]) {
        //初始化会话
        _captureSession = [[AVCaptureSession alloc]init];
        if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            NSLog(@"当前录制的分辨率是 1280x720");
            _captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
        } else {
            NSLog(@"error 当前录制的分辨率不能是 1280x720");
        }
        
        //获得输入设备
        AVCaptureDevice * captrueDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
        if (captrueDevice) {
            NSLog(@"取得后置摄像头");
        } else {
            NSLog(@"取得后置摄像头失败");
        }
        
        //添加一个音频输入设备
        AVCaptureDevice * audioCaptrueDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
        NSLog(@"音频设备 == %@",[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio]);
        
        //根据输入这杯初始化设备输入对象，用于获得输入数据
        NSError * error = nil;
        _captureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:captrueDevice error:&error];
        if (error) {
            NSLog(@"取得设备输入对象时出错，错误原因 == %@",error.localizedDescription);
        }

        
        //初始化设备输出对象，用于获得输出数据
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
        
        //将设备输入到会话中去
        if ([_captureSession canAddInput:_captureDeviceInput]) {
            
            [_captureSession addInput:_captureDeviceInput];
            
            AVCaptureConnection * captureConnection = [_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
            if ([captureConnection isVideoStabilizationSupported]) {
                captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
            }
        }
        
        //将设备输出添加到会话中
        if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
            [_captureSession addOutput:_captureMovieFileOutput];
        }
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self testMethod1];
    
}
- (void)testMethod1 {
  
    UIView * cameraView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    cameraView.backgroundColor = [UIColor lightGrayColor];
    _userCamera = cameraView;
    [self.view addSubview:cameraView];
    
    //创建视频预览层，用于实时展示摄像头状态
    _captrueVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    
    _userCamera.layer.masksToBounds = true;
    
    _captrueVideoPreviewLayer.frame = _userCamera.layer.bounds;
    _captrueVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [_userCamera.layer addSublayer:_captrueVideoPreviewLayer];
    
}
- (void)areaChange:(NSNotification *)notification {
    NSLog(@"notification == %@",notification);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
}
/*
 取得指定位置的摄像头
 */
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    
    NSArray * cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice * camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
    
}

@end
