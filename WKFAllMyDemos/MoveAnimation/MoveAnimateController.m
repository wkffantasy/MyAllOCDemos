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
#import "UINavigationController+FDFullscreenPopGesture.h"

#define maxMoveHeight  60

@interface MoveAnimateController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UIView * topView;
@property (nonatomic,weak) CurveView * curve;
@property (nonatomic,weak) UITableView * tableView;

@end

@implementation MoveAnimateController

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  
  
  
}
- (void)viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
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
   NSLog(@"move animation controller will dealloc");
  
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
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.and.height.mas_equalTo(40);
    }];
  
}
- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
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
  tableView.rowHeight = 100;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return  20;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString * cellId = @"cellId";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
  }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
  return cell;
  
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [self.navigationController popViewControllerAnimated:YES];
}




@end
