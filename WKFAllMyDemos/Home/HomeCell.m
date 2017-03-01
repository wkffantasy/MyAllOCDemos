//
//  HomeCell.m
//  WKFAllMyDemos
//
//  Created by fantasy on 16/9/5.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "HomeCell.h"

//lib
#import "Masonry.h"

#define  margin 20

@interface HomeCell ()

@property (weak, nonatomic) UILabel * nameLabel;

@property (weak, nonatomic) UILabel * descriptionLabel;

@property (weak, nonatomic) UILabel * statusLabel;

@property (weak, nonatomic) UIView * sepView;

@property (weak, nonatomic) UIView * circleView;

@end

@implementation HomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
  
  static NSString * cellId = @"HomeCell";
  HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
  }
  return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    self.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = RandomColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupViews];
    
  }
  return self;
  
}
- (void)setupViews{
  
  UILabel * nameLabel = [UILabel new];
  nameLabel.textColor = HEXRGBCOLOR(0x454545);
  nameLabel.font = [UIFont systemFontOfSize:18];
  _nameLabel = nameLabel;
  [self addSubview:nameLabel];
  
  UILabel * descriptionLabel = [UILabel new];
  descriptionLabel.textColor = HEXRGBCOLOR(0x666666);
  descriptionLabel.font = [UIFont systemFontOfSize:15];
  descriptionLabel.numberOfLines = 0;
  _descriptionLabel = descriptionLabel;
  [self addSubview:descriptionLabel];
  
  UILabel * statusLabel = [UILabel new];
  statusLabel.textColor = HEXRGBCOLOR(0xff9700);
  statusLabel.font = [UIFont systemFontOfSize:13];
  _statusLabel = statusLabel;
  [self addSubview:statusLabel];
  
  UIView * sepView = [UIView new];
  sepView.backgroundColor = HEXRGBCOLOR(0xf2f2f2);
  _sepView = sepView;
  [self addSubview:sepView];
  
}

- (void)setModel:(HomeModel *)model{
  
  _model = model;
  //data
  _nameLabel.text = _model.title;
  _descriptionLabel.text = _model.titleDescription;
  _statusLabel.text = _model.status;
  
  //layout
  [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.right.mas_equalTo(-margin);
    make.top.mas_equalTo(margin);
    
  }];
  
  [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.left.mas_equalTo(margin);
    make.top.mas_equalTo(margin);
    make.right.mas_lessThanOrEqualTo(self.statusLabel.mas_left).offset(-margin);
    
  }];
  
  [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    make.left.mas_equalTo(margin);
    make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(margin/2);
    make.right.mas_equalTo(-margin);
    make.bottom.mas_equalTo(-margin/2);
    
  }];
  
  
  [_sepView mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.updateExisting = YES;
    
    make.bottom.and.right.mas_equalTo(0);
    make.height.mas_equalTo(0.5);
    make.left.mas_equalTo(margin);
    
    
  }];
  
}

@end
