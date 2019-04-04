//
//  RollingCircleView.h
//  循环滚动
//
//  Created by fantasy on 16/8/25.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickItemBlock)(int index);

@interface RollingCircleView : UIView


/**
 *  使用frame 来创建循环滚动的视图
 *
 *  @param itemMargin 每一个item之间的间隙
 *  @param itemSize   每一个itme的size，item的宽度＋itemMargin*2 必须小于等于屏幕的宽度
 *  @param dataArray  所有的数据
 *  @param clickItem  点击每一个item的block回调
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithoutMasonryItemMargin:(CGFloat)itemMargin
                          itemSize:(CGSize)itemSize
                         dataArray:(NSArray *)dataArray
                 andClickItemBlock:(ClickItemBlock)clickItem;


/**
 *  使用masonry来创建循环滚动的视图
 *
 *  @param itemMargin 每一个item之间的间隙
 *  @param itemWidth  每一个itme的宽度，itemWidth＋itemMargin*2 必须小于等于屏幕的宽度
 *  @param dataArray  所有的数据
 *  @param clickItem  点击每一个item的block回调
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithMasonryItemMargin:(CGFloat)itemMargin
                                itemWidth:(CGFloat)itemWidth
                                dataArray:(NSArray *)dataArray;

@end
