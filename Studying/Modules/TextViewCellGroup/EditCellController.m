//
//  EditCellController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "EditCellController.h"

//view
#import "EditCell.h"

//lib or others
#import "Masonry.h"

@interface EditCellController ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic) UITableView * tableView;
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation EditCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i<30; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"cell --%d",i]];
    }
    [self setupView];
}
- (void)setupView {
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
}

#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditCell * cell = [EditCell cellWithTableView:tableView];
    [cell updateThisText:_dataArray[indexPath.row]];
    
    __weak typeof(self) weakSelf = self;
    cell.shouldUpdateThisRow = ^(NSString * thisText){
        weakSelf.dataArray[indexPath.row] = thisText;
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    return cell;
}

- (void)dealloc{
    NSLog(@"this controller will dealloc");
}

@end
