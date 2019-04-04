//
//  EditCell.m
//  WKFAllMyDemos
//
//  Created by fantasy on 17/6/15.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "EditCell.h"

//lib or others
#import "Masonry.h"

@interface EditCell ()<UITextViewDelegate>

@property (weak, nonatomic) UIView * sepView;

@property(weak,nonatomic) UITextView * textView;

@end

@implementation EditCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * cellId = @"EditCell";
    EditCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[EditCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    return  cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor greenColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}
- (void)setupView{
    
    UITextView * textView = [[UITextView alloc]init];
    textView.scrollEnabled = NO;
    textView.delegate = self;
    _textView = textView;
    [self addSubview:textView];
    
    UIView * sepView = [[UIView alloc]init];
    sepView.backgroundColor = [UIColor redColor];
    _sepView = sepView;
    [self addSubview:sepView];

}
#pragma UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textView.text == %@",textView.text);
    if (self.shouldUpdateThisRow) {
        self.shouldUpdateThisRow(textView.text);
    }
}

- (void)updateThisText:(NSString *)text{
    _textView.text = text;
    [self layoutIt];
}
- (void)layoutIt{
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.updateExisting = YES;
        make.top.and.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    [_sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.updateExisting = YES;
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(_textView.mas_bottom).offset(10);
    }];
}

@end
