//
//  ImageSizeTool.m
//  SmartStudy
//
//  Created by fantasy on 16/1/29.
//  Copyright © 2016年 Innobuddy Inc. All rights reserved.
//

#import "ImageSizeTool.h"

#import "UIImageView+WebCache.h"

@implementation ImageSizeTool

+ (instancetype)shareImageUrlTool{
  
  static dispatch_once_t onceToken;
  static ImageSizeTool *ret = nil;
  dispatch_once(&onceToken, ^{
    
    ret = [[ImageSizeTool alloc]init];
    
  });
  return ret;
  
}

- (void)imageUrlStringWithUrl:(NSString *)urlString
              andSuccessBlock:(DownlownImageSucces)imageRealSize
                   notComplet:(NotComplete)notReal{
  
  if (!urlString) {
    notReal();
    return;
  }
//    asdadas 
  NSParameterAssert([urlString isKindOfClass:[NSString class]]);
  
  UIImage * image = nil;
  
  NSURL *url = [NSURL URLWithString:urlString];
    
  SDImageCache *cache = [SDWebImageManager sharedManager].imageCache;
  
  NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
  
  if ([cache imageFromMemoryCacheForKey:key]) {
    
    image = [cache imageFromMemoryCacheForKey:key];
    if (imageRealSize) {
      imageRealSize(image.size,image.size.height / image.size.width);
    }
    
  }else if ([cache diskImageExistsWithKey:key]) {
    
    image = [cache imageFromDiskCacheForKey:key];
    if (imageRealSize) {
      imageRealSize(image.size,image.size.height / image.size.width);
    }
    
  }else {
    
    if (image == nil) {
  
      [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image && !error && finished) {
          dispatch_async(dispatch_get_main_queue(), ^{
            [cache storeImage:image forKey:key];
            if (imageRealSize) {
              
              imageRealSize(image.size,image.size.height / image.size.width);
            }
          });
        }
      }];
      
      if (notReal) {
        notReal();
      }
    }
    

  }
  
  
  
}



@end
