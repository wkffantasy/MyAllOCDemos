//
//  RollingCircleView.m
//  循环滚动
//
//  Created by fantasy on 16/8/25.
//  Copyright © 2016年 fantasy. All rights reserved.
//

//view
#import "RollingCircleView.h"
#import "RollingItemView.h"

//lib  or others
#import "Masonry.h"

#define  pageControlH  20
#define  ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBCOLOR(h) RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBACOLOR(h,a) RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)

@interface RollingCircleView () <UIScrollViewDelegate>

@property (copy,nonatomic)    ClickItemBlock clickItem;

@property (weak,nonatomic)    UIScrollView *myScrollView;

@property (strong,nonatomic)  NSArray *myDataArray;

@property (assign, nonatomic) CGSize itemSize;
@property (assign, nonatomic) CGFloat itemWidth;

@property (assign, nonatomic) CGFloat itemMargin;


@property (assign, nonatomic) CGFloat realItemWidth;


@end

@implementation RollingCircleView

- (instancetype)initWithMasonryItemMargin:(CGFloat)itemMargin itemWidth:(CGFloat)itemWidth dataArray:(NSArray *)dataArray{
  
  if (self = [super init]) {
    
    NSAssert(ScreenWidth >= itemWidth + 2*itemMargin , @"这样的循环滚动 没有意义");
    NSAssert(itemMargin >= 0, @"");
    NSAssert(ScreenWidth >= itemWidth, @"");
    NSAssert(dataArray.count>0, @"必须有数据");
    
    self.backgroundColor = [UIColor whiteColor];
    self.itemMargin = itemMargin;
    self.itemWidth = itemWidth;
    self.realItemWidth = self.itemWidth + self.itemMargin;
    
    [self initDataArrayWithArray:dataArray];
    [self setupViewsWithMasonry];
    
  }
  return self;
  
}

- (instancetype)initWithoutMasonryItemMargin:(CGFloat)itemMargin itemSize:(CGSize)itemSize dataArray:(NSArray *)dataArray andClickItemBlock:(ClickItemBlock)clickItem{
  
  if (self = [super init]) {
    
    NSAssert(ScreenWidth >= itemSize.width + 2*itemMargin , @"这样的循环滚动 没有意义");
    NSAssert(itemMargin >= 0, @"");
    NSAssert(ScreenWidth >= itemSize.width, @"");
    NSAssert(dataArray.count>0, @"必须有数据");
    
    self.backgroundColor = [UIColor whiteColor];
    self.clickItem = clickItem;
    self.itemMargin = itemMargin;
    self.itemSize = itemSize;
    self.realItemWidth = self.itemSize.width + self.itemMargin;
    
    [self initDataArrayWithArray:dataArray];
    [self setupViewsWithoutMasonry];
    
  }
  return self;
  
}

- (void)setupViewsWithMasonry{
  
  NSAssert(self.myDataArray.count !=2 , @"");
  NSAssert(self.myDataArray.count !=3 , @"");
  
  //scrollView
  UIScrollView *scrollView = [[UIScrollView alloc]init];
  scrollView.clipsToBounds = NO;
  scrollView.backgroundColor = [UIColor redColor];
  scrollView.bounces=NO;
  scrollView.delegate=self;
  scrollView.pagingEnabled=YES;
  scrollView.showsHorizontalScrollIndicator=NO;
  _myScrollView=scrollView;
  [self addSubview:scrollView];
  
  [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.top.and.bottom.mas_equalTo(0);
    make.centerX.mas_equalTo(self.mas_centerX);
    make.width.mas_equalTo(self.realItemWidth);
    
    
  }];
  
  UIView * containerView = [UIView new];
  containerView.backgroundColor = HEXRGBCOLOR(0xf2f2f4);
  [scrollView addSubview:containerView];
  [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.edges.equalTo(_myScrollView);
    make.width.greaterThanOrEqualTo(_myScrollView.mas_width);
    make.height.equalTo(_myScrollView.mas_height);
    
  }];
  
  
  UIView * lastView = nil;
  for (int i = 0; i < self.myDataArray.count; i++) {
    
    UIView * itemView = [UIView new];
    
    itemView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:itemView];
  
    if (lastView) {
      
      [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lastView.mas_right);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.realItemWidth);
        if (i==self.myDataArray.count-1) {
          make.right.mas_equalTo(0);
        }
      }];
      
    } else {
      
      [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.realItemWidth);
      }];
      
    }
    
    lastView = itemView;
    
    NSDictionary * dict = self.myDataArray[i];
    
    RollingItemView * item = [[RollingItemView alloc]initWithTitle:dict[@"title"] andDetailTitle:dict[@"detail"] andImageName:dict[@"image"]];
    [itemView addSubview:item];
    item.backgroundColor = HEXRGBCOLOR(0xf2f2f4);
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
      
      make.top.and.bottom.mas_equalTo(0);
      make.left.mas_equalTo(self.itemMargin/2);
      make.right.mas_equalTo(-self.itemMargin/2);
      
    }];
  }
  
  if (self.myDataArray.count != 1) {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
      [self.myScrollView setContentOffset:CGPointMake(self.realItemWidth, 0) animated:NO];
    });
    
  }
  
  
}

- (void)setupViewsWithoutMasonry{
  
  NSAssert(self.myDataArray.count !=2 , @"");
  NSAssert(self.myDataArray.count !=3 , @"");
  
  //scrollView
  UIScrollView *scrollView = [[UIScrollView alloc]init];
  scrollView.bounces=NO;
  scrollView.delegate=self;
  scrollView.clipsToBounds = NO;
  scrollView.pagingEnabled=YES;
  scrollView.showsHorizontalScrollIndicator=NO;
  scrollView.backgroundColor = [UIColor whiteColor];
  scrollView.contentSize = CGSizeMake(self.realItemWidth * self.myDataArray.count, self.itemSize.height);
  scrollView.frame = CGRectMake((ScreenWidth - self.realItemWidth)/2, 0, self.realItemWidth, self.itemSize.height);
  _myScrollView=scrollView;
  [self addSubview:scrollView];
  
  for (int i = 0; i<self.myDataArray.count; i++) {
    
    UIView * containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.frame =CGRectMake(i * self.realItemWidth, 0, self.realItemWidth, self.itemSize.height);
    [self.myScrollView addSubview:containerView];
    
    
    UIImageView *myImageView = [[UIImageView alloc]init];
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.cornerRadius = 5;
    NSString *imageName = self.myDataArray[i];
    myImageView.image = [UIImage imageNamed:imageName];
    myImageView.userInteractionEnabled=YES;
    myImageView.tag=i+100;
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickScrollViewImage:)];
    [myImageView addGestureRecognizer:tap];
    
    myImageView.frame = CGRectMake(self.itemMargin/2, 0, self.itemSize.width, self.itemSize.height);
    [containerView addSubview:myImageView];
    
  }
  
  if (self.myDataArray.count != 1) {
    
    [self.myScrollView setContentOffset:CGPointMake(self.realItemWidth, 0) animated:NO];
    
  }
  
}
#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGPoint point =scrollView.contentOffset;
  
  if (point.x==0) {
    
    [self.myScrollView setContentOffset:CGPointMake(self.realItemWidth * (self.myDataArray.count-2), 0) animated:NO];
    
  }else if (point.x==self.realItemWidth*(self.myDataArray.count-1)){
    
    [self.myScrollView setContentOffset:CGPointMake(self.realItemWidth, 0) animated:NO];
    
  }
}



-(void)clickScrollViewImage:(UITapGestureRecognizer *)tap{
  
  UIView * view = tap.view;
  
  if (self.clickItem) {
    self.clickItem((int)view.tag - 100);
  }
  
}

- (void)initDataArrayWithArray:(NSArray *)array{
  
  if (array.count == 1) {
    self.myDataArray = array;
    return;
  }
  
  NSMutableArray * temArray = [[NSMutableArray alloc]initWithArray:array];
  
  [temArray insertObject:[array lastObject] atIndex:0];
  
  [temArray addObject:[array firstObject]];
  
  self.myDataArray = temArray;
  
  NSAssert(self.myDataArray.count == array.count+2, @"");
  
}

@end
