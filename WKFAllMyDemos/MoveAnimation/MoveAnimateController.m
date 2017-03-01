//
//  MoveAnimateController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/3/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "MoveAnimateController.h"

//view
#import "CurveView.h"


//lib
#import "Masonry.h"

#define maxMoveHeight  60

@interface MoveAnimateController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UIView * topView;
@property (nonatomic,weak) CurveView * curve;
@property (nonatomic,weak) UITableView * tableView;

@end

@implementation MoveAnimateController

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  
  [self.navigationController setNavigationBarHidden:YES];
  
}
- (void)viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO];
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
  
  [self setupTopView];
  [self setupCurveView];
  [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
  
  [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
  
}

- (void)setupTopView {
  
  UIView * topView = [[UIView alloc]init];
  topView.backgroundColor = [UIColor redColor];
  [self.view addSubview:topView];
  _topView = topView;
  [topView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.and.right.and.top.mas_equalTo(0);
    make.height.mas_equalTo(110);
    
  }];
  
}
- (void)setupCurveView {
  
  CurveView * curve = [[CurveView alloc]init];
  [self.view addSubview:curve];
  _curve = curve;
  
  [curve mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.left.and.right.mas_equalTo(0);
    make.top.mas_equalTo(self.topView.mas_bottom);
    make.height.mas_equalTo(maxMoveHeight/2);
    
  }];
  
}
- (void)setupTableView {
  
  UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
  _tableView =tableView;
  [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
  tableView.delegate = self;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
  [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.left.and.right.and.bottom.mas_equalTo(0);
    make.top.mas_equalTo(self.curve.mas_bottom);
    
  }];
  
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
  if ([keyPath isEqualToString:@"contentOffset"]) {
    
    CGPoint currentPoint = CGPointFromString([NSString stringWithFormat:@"%@",change[@"new"]]);
    CGFloat currentY = currentPoint.y;
    NSLog(@"currentY ==%f",currentY);
    if (currentY > maxMoveHeight) {
      currentY = maxMoveHeight;
    } else if (currentY < 0) {
      currentY = 0;
    }
    currentY = maxMoveHeight - currentY;
    [self beganAnimate:currentY];
    
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  
}
- (void)beganAnimate:(CGFloat)currentY {
  
  [self.curve updateThisHeight:currentY];
  [self.curve mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.left.and.right.mas_equalTo(0);
    make.top.mas_equalTo(self.topView.mas_bottom);
    make.height.mas_equalTo(currentY/2);
    
  }];
  
  
}
// about table view
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return 100;
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return  20;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString * cellId = @"cellId";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
  return cell;
  
  
}



@end
