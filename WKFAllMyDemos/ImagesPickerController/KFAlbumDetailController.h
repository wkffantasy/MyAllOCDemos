//
//  KFAlbumDetailController.h
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^DidClickCompleteButtonBlock)(NSArray * imageArray);

@interface KFAlbumDetailController : UIViewController

@property (nonatomic,strong) ALAssetsGroup * assetsGroup;
@property (nonatomic,copy) DidClickCompleteButtonBlock completeBlock;

@end
