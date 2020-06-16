//
//  TestRetainCircleView.h
//  WKFAllMyDemos
//
//  Created by fantasy on 2020/6/14.
//  Copyright © 2020 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestRetainCircleView : UIView

@property (nonatomic, copy) void(^didClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
