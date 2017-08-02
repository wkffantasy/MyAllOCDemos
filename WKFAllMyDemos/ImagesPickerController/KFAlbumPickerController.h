//
//  KFAlbumPickerController.h
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickCancelButtonBlock)();
typedef void(^DidClickCompleteButtonBlock)(NSArray  * imageArray);
typedef void(^FailureBlock)(NSError *error);

@interface KFAlbumPickerController : UIViewController


@property (nonatomic,assign) int maxImageCount;
@property (nonatomic,copy) DidClickCancelButtonBlock cancelBlock;
@property (nonatomic,copy) DidClickCompleteButtonBlock completeBlock;
@property (nonatomic,copy) FailureBlock failedBlock;
@property (nonatomic,assign) BOOL isFromCamera;

@end
