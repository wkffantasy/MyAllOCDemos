//
//  UtilsMacros.h
//  Studying
//
//  Created by wangkongfei on 2019/4/2.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

///**************重写NSLog,Debug模式下打印日志和当前行数**************///
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

///****************** 系统对象区 ***************************/////
#define kApplication [UIApplication sharedApplication]

#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)


///***************** 数据验证区 ***************************///
#define SafeStr(f)(StrValid(f)?f:@"")
#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)
#define ValidStr(f)(f!=nil &&[f isKindOfClass:[NSString class]]&& ![f isEqualToString:@""])
#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])
#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)
#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])
#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])
//![f isKindOfClass:[NSNull class]]&&
//数组越界判定
#define ISINDEXINRANGEARR(idx,arr)\
(idx >=0 && idx < arr.count)

///***************** 颜色区 ***************************///
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBCOLOR(h) RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBACOLOR(h,a) RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//随机色
#define RandomColor RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


//解决循环引用
#define weakify(va) \
autoreleasepool {} \
__weak __typeof__(va) metamacro_concat(va, _weak_) = (va);

#define strongify(va) \
try {} @finally {} \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(va) va = metamacro_concat(va, _weak_);\
_Pragma("clang diagnostic pop")
#define metamacro_concat(A, B) A ## B

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//iPhoneX系列
#define Height_StatusBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
#define Height_NavBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)


#endif /* UtilsMacros_h */
