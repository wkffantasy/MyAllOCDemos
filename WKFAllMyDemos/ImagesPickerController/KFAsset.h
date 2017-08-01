//
//  KFAsset.h
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface KFAsset : NSObject

@property (nonatomic,strong) ALAsset * asset;
@property (nonatomic,assign) BOOL selected;

@end
