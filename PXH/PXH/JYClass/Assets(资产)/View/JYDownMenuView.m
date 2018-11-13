//
//  JYDownMenuView.m
//  PXH
//
//  Created by LX on 2018/6/12.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYDownMenuView.h"


#define Row_H   45.f
#define Max_H   200.f

@interface JYDownMenuView ()<UITableViewDelegate, UITableViewDataSource>

/// 蒙版View
@property (nonatomic, strong) UIControl         *maskView;

@property (nonatomic, strong) UITableView       *tableView;

@end

static NSString *listTableCellID = @"ListTableCell_ID";

@implementation JYDownMenuView

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor  = [UIColor grayColor];
        _tableView.separatorInset  = UIEdgeInsetsMake(0, 0, 0, -15);
        _tableView.rowHeight       = Row_H;
        
        [self addSubview:_tableView];
        
    }
    
    return _tableView;
}

-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_maskView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    
    return _maskView;
}


-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        
//        self.layer.borderColor = [UIColor grayColor].CGColor;
//        self.layer.borderWidth = 1.f;
        
    }
    return self;
}

-(void)show
{
    UIWindow *kWindow = [[UIApplication sharedApplication] keyWindow];
    [kWindow addSubview:self.maskView];
    [kWindow addSubview:self];
    
    CGFloat height = Row_H * self.dataSource.count;
    height = (height < CGRectGetHeight(self.frame))?height:CGRectGetHeight(self.frame);
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 1.f;
        CGRect frames = self.frame;
        frames.size.height = height;
        self.frame = frames;
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(frames), height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0;
        CGRect frames = self.frame;
        frames.size.height = 0;
        self.frame = frames;
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(frames), 0);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


#pragma mark - UITableView Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listTableCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listTableCellID];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.textLabel.font          = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textColor     = [UIColor blackColor];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    !_selectedCellBlack?:_selectedCellBlack(self, indexPath.row, cell.textLabel.text);
    
    [self hide];
}


@end
