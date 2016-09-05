//
//  ImageSizeTool.h
//  SmartStudy
//
//  Created by fantasy on 16/1/29.
//  Copyright © 2016年 Innobuddy Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 * 这个单例就是为了获取图片的真实尺寸
 */
#define ImageRealsizeTool [ImageSizeTool shareImageUrlTool]

typedef void(^DownlownImageSucces)(CGSize imageRealSize,CGFloat ratio);
typedef void(^NotComplete)();

@interface ImageSizeTool : NSObject


+ (instancetype)shareImageUrlTool;


/**
 *  这个类是为了获取图片的真正的宽高比例
 *
 *  @param urlString     图片的url
 *  @param imageRealSize 当这个图片下载成功后，成功的回调
 *  @param notReal       当这个图片没有下载成功的时候，调用这个block，在这个block里面 可以设置frame，当图片下载成功后，成功的回调中有宽高比，在设置frame
 */

- (void)imageUrlStringWithUrl:(NSString *)urlString
              andSuccessBlock:(DownlownImageSucces)imageRealSize
                   notComplet:(NotComplete)notReal;



@end
