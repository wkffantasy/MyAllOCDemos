//
//  KFAsset.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "KFAsset.h"

@implementation KFAsset

- (UIImage *)originImage {
    
    return [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullResolutionImage];
    
}

@end
