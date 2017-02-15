//
//  HaveMarginScrollController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 16/9/7.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "HaveMarginScrollController.h"

//lib or others
#import "Masonry.h"

//view
#import "RollingCircleView.h"

@interface HaveMarginScrollController ()

@property (strong, nonatomic) NSMutableArray * dataArray;

@end

@implementation HaveMarginScrollController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    CGFloat itemWidth = 300;
    CGFloat itemHeight = itemWidth * 40 / 64;
    
    //scrollView
    RollingCircleView * rollView = [[RollingCircleView alloc]initWithoutMasonryItemMargin:20 itemSize:CGSizeMake(itemWidth, itemHeight) dataArray:self.dataArray andClickItemBlock:^(int index) {
        
        NSLog(@"index == %d",index);
        
    }];
    rollView.frame = CGRectMake(0, 100, ScreenWidth, itemHeight);
    [self.view addSubview:rollView];
    
    NSArray * array = @[
                        @{@"title":@"第1天，xxxxxxx",
                          @"detail":@"七里香",
                          @"image":@"01",
                          },
                        @{@"title":@"第2天，xxxxxxx",
                          @"detail":@"发如雪",
                          @"image":@"02",
                          },
                        @{@"title":@"第三天，xxxxxxx",
                          @"detail":@"东风破",
                          @"image":@"03",
                          },
                        @{@"title":@"第四天，xxxxxxx",
                          @"detail":@"青花瓷",
                          @"image":@"04",
                          },
                        ];
    
    
    RollingCircleView * rollView2 = [[RollingCircleView alloc]initWithMasonryItemMargin:20 itemWidth:300 dataArray:array];
    [self.view addSubview:rollView2];
    [rollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        
    }];
    
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        
        _dataArray = [NSMutableArray array];
        
        // 改变imageCount的个数 最多是10
        int imageCount = 4;
        for (int i = 0; i < imageCount; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"%02d",i+1];
            [_dataArray addObject:imageName];
            
        }
    }
    return _dataArray;
}

@end
