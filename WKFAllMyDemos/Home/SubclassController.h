//
//  SubclassController.h
//  WKFAllMyDemos
//
//  Created by fantasy on 17/2/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeModel.h"

typedef void(^ClickCellBlock)(HomeModel * model);

@interface SubclassController : UITableViewController

@property (nonatomic,strong) NSArray * dataArray;
@property (copy, nonatomic) ClickCellBlock clickCell;


@end
