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

//constrollers

#import "MarqueeController.h"
#import "AlphabetController.h"
#import "NoMarginScrollController.h"
#import "VideoDemoController.h"
#import "HaveMarginScrollController.h"
#import "WaveAnimationController.h"
#import "MoveAnimateController.h"
#import "EditCellController.h"
#import "SubclassController.h"
#import "IdentifyingCodeController.h"
#import "ImagePickerEntranceController.h"

#import "RunTimeController.h"
#import "WebViewController.h"
#import "BaiduMapController.h"
#import "AlbumController.h"
#import "VideoRecordController.h"
#import "GCDController.h"

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

  cell.model = model;
  
  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    HomeModel * model = self.dataArray[indexPath.row];
    id thisVC = [[NSClassFromString(model.jumpTo) alloc]init];
    if (thisVC && [thisVC isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:thisVC animated:YES];
    }
  
}

@end
