//
//  SubclassController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/2/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

//controller
#import "SubclassController.h"

//view
#import "HomeCell.h"

@interface SubclassController ()<UITableViewDelegate>

@end

@implementation SubclassController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 50;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.dataArray.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  HomeCell * cell = [HomeCell cellWithTableView:tableView];
  
  HomeModel * model = self.dataArray[indexPath.row];
//  NSLog(@"model.title == %@",model.title);
  
  cell.model = model;
  
  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  HomeModel * model = self.dataArray[indexPath.row];
  if (self.clickCell) {
    self.clickCell(model);
  }
  
}



@end
