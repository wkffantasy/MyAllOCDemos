//
//  TestDemosController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 2017/10/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "TestDemosController.h"

//libs
#import "Masonry.h"
#import <TCBlobDownload/TCBlobDownload.h>
#import "FGGDownloadManager.h"

#define urlString @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
#define urlString1 @"http://dota2.dl.wanmei.com/dota2/client/DOTA2Setup20160329.zip"
#define urlString2 @"http://dota2.dl.wanmei.com/dota2/client/DOTA2Setup20160329.zip"



@interface TestDemosController ()

@end

@implementation TestDemosController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"TestDemos";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupViews];
    
}
- (void)dealloc{
   TCBlobDownloadManager * shareManager = [TCBlobDownloadManager sharedInstance];
    [shareManager cancelAllDownloadsAndRemoveFiles:NO];
}


- (void)clickDownloadButton1:(UIButton*)button{
    NSString * kCachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * path = [kCachePath stringByAppendingString:@"/Videos/111.mp4"];
    NSLog(@"kCachePath ==%@",kCachePath);
    NSLog(@"path ==%@",path);
    [[FGGDownloadManager shredManager] downloadWithUrlString:urlString toPath:path process:^(float progress, NSString *sizeString, NSString *speedString) {
        NSLog(@"progress ==%f",progress);
    } completion:^{
        NSLog(@"completion");
    } failure:^(NSError *error) {
        NSLog(@"error ==%@",error.localizedDescription);
    }];
    
    UIStatusBar * bar = [[UIStatusBar alloc]init];
    
//    FGGDownloadManager * downloadManger = [FGGDownloadManager shredManager];
//    [downloadManger downloadWithUrlString:urlString toPath:nil process:^(float progress, NSString *sizeString, NSString *speedString) {
//        NSLog(@"progress ==%f sizeString==%@ speedString==%@",progress,sizeString,speedString);
//    } completion:^{
//        NSLog(@"completion");
//    } failure:^(NSError *error) {
//        NSLog(@"error ==%@",error.localizedDescription);
//    }];
    
//    TCBlobDownloadManager * shareManager = [TCBlobDownloadManager sharedInstance];
//
//    NSURL * url = [NSURL URLWithString:urlString];
//
//    TCBlobDownloader * downloader = [shareManager startDownloadWithURL:url customPath:nil firstResponse:^(NSURLResponse *response) {
//
//        NSLog(@"firstResponse response==%@",response);
//
//    } progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
//        NSLog(@"remainingTime ==%ld",(long)remainingTime);
//        NSLog(@"progress ==%f",progress);
//        NSLog(@"totalLength ==%f",totalLength);
//
//    } error:^(NSError *error) {
//        NSLog(@"error ==%@",error.localizedDescription);
//
//    } complete:^(BOOL downloadFinished, NSString *pathToFile) {
//        NSLog(@"downloadFinished ==%d",downloadFinished);
//        NSLog(@"pathToFile ==%@",pathToFile);
//    }];
    
}

- (void)setupViews{
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor blueColor];
    [button1 addTarget:self action:@selector(clickDownloadButton1:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"download1" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(64+20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}


@end
