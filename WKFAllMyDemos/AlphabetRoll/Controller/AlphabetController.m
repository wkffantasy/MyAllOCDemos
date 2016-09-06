//
//  AlphabetController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/6.
//  Copyright © 2016年 fantasy. All rights reserved.
//

//controller
#import "AlphabetController.h"

//model
#import "MyCarGroupModel.h"
#import "MyCarModel.h"

//view
#import "MyCarCell.h"
#import "MyCarsView.h"

//lib or others
#import "Masonry.h"

@interface AlphabetController () <UITableViewDataSource,UITableViewDelegate>

//存放数据的数组
@property (strong,nonatomic) NSMutableArray * dataArray;

@property (weak,nonatomic) UITableView * tableView;

//自定义右侧view
@property (weak,nonatomic) MyCarsView * myView;

@end

@implementation AlphabetController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = WKFColor(200, 200, 200, 1);
  
  //创建tableView
  [self setupTableView];
  
  //创建右侧索引的view
  [self setupRightIndexView];
  
}
//创建tableView
-(void)setupTableView{
  
  UITableView *tableView = [[UITableView alloc]init];
  tableView.backgroundColor = [UIColor whiteColor];
  tableView.delegate=self;
  tableView.dataSource=self;
  tableView.estimatedRowHeight = 50;
  tableView.rowHeight = UITableViewAutomaticDimension;
  tableView.sectionHeaderHeight = 30;
  tableView.showsVerticalScrollIndicator=NO;
  tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  _tableView=tableView;
  [self.view addSubview:tableView];
  
  [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.and.right.and.bottom.and.top.mas_equalTo(0);
    
  }];
  
  [self.titleView updateText:@"上下滑动右侧的字母表有惊喜哦" andTitleFont:nil andTitleColor:nil];
  
  
  
}

//创建右侧索引的view
-(void)setupRightIndexView{
  
  NSMutableArray *array = [NSMutableArray array];
  for (MyCarGroupModel *model in self.dataArray) {
    
    [array addObject:model.title];
    
  }
  
  CGFloat singleH = 20;
  
  @weakify(self);
  
  MyCarsView *myView = [[MyCarsView alloc]initWithDataArray:array withSinglLabelH:singleH andTouchEndBlock:^(int tag) {
    @strongify(self);
    //touch end
    if (tag<0) {
      tag=0;
    }else if (tag>self.dataArray.count-1){
      tag=(int)self.dataArray.count-1;
    }
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:tag];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
  }];
  
  _myView = myView;
  
  [self.view addSubview:myView];
  
  [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.centerY.mas_equalTo(self.tableView.mas_centerY);
    make.right.mas_equalTo(0);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(singleH * self.dataArray.count);
    
  }];
  
}


#pragma mark - UITableViewDataSource,,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  NSAssert(self.dataArray.count >= 1, @"");
  return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  MyCarGroupModel *model =self.dataArray[section];
  return model.cars.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MyCarCell *cell = [MyCarCell cellWithTableView:tableView];
  MyCarGroupModel *groupModel =self.dataArray[indexPath.section];
  MyCarModel *model =groupModel.cars[indexPath.row];
  cell.model=model;
  return cell;
  
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  
  MyCarGroupModel *model =self.dataArray[section];
  return model.title;
}

- (NSMutableArray *)dataArray{
  
  if (_dataArray ==nil) {
    
    _dataArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:path];
    
    NSAssert(array.count > 0, @"");
    
    for (NSDictionary *dict1 in array) {
      
      MyCarGroupModel *model = [MyCarGroupModel MyCarGroupModelWithDict:dict1];
      
      [_dataArray addObject:model];
      
    }
    
  }
  return _dataArray;
  
}



@end
