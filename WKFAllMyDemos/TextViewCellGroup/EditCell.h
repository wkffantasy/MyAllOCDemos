//
//  EditCell.h
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShouldUpdateThisRowBlock)(NSString * text);

@interface EditCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)updateThisText:(NSString *)text;

@property (copy, nonatomic)ShouldUpdateThisRowBlock shouldUpdateThisRow;

@end
