//
//  HeaderSelectView.h
//  SmartStudy
//
//  Created by fantasy on 16/4/13.
//  Copyright © 2016年 Innobuddy Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickButtonsBlock)(int tag);

@interface HeaderSelectView : UIView

//button  image
- (instancetype)initWithSelectedImagesArray:(NSArray *)selectedImageArray
                        andNormalImageArray:(NSArray *)normalImageArray;

//button title
- (instancetype)initWithTitleArray:(NSArray *)titleArray
                   andSeletedColor:(UIColor *)seletedColor
                    andNormalColor:(UIColor *)normalColor;

- (void)updateSelectedIndex:(int )tag;

@property (copy, nonatomic) DidClickButtonsBlock clickButton;

@property (strong, nonatomic) UIColor * colorSepView;
@property (strong, nonatomic) UIColor * colorMoveing;

@end
