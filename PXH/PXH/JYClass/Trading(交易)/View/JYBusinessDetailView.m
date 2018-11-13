//
//  JYBusinessDetailView.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBusinessDetailView.h"
#import "JYBusinessDetailCell.h"




@interface JYBusinessDetailView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;

@end


@implementation JYBusinessDetailView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    
    [self addSubview:self.tableView];
    
    UIView *headView = [UIView new];
    headView.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGDetailHead);
    [self addSubview:headView];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"时间";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    label1.font = [UIFont systemFontOfSize:13];
    [headView addSubview:label1];
    
    UILabel *label4 = [UILabel new];
    label4.text = @"方向";
    label4.textAlignment = NSTextAlignmentLeft;
    label4.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    label4.font = [UIFont systemFontOfSize:13];
    [headView addSubview:label4];
    
    
    self.label2 = [UILabel new];
    self.label2.text = @"价格";
    self.label2.textAlignment = NSTextAlignmentRight;
    self.label2.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    self.label2.font = [UIFont systemFontOfSize:13];
    [headView addSubview:self.label2];
    
    self.label3 = [UILabel new];
    self.label3.text = @"数量";
    self.label3.textAlignment = NSTextAlignmentRight;
    self.label3.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    self.label3.font = [UIFont systemFontOfSize:13];
    [headView addSubview:self.label3];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(37);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(headView).offset(10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(label1.mas_right).offset(10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(label4.mas_right).offset(10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.right.equalTo(headView).offset(-10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    
    //    WS(weakSelf);
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        if (weakSelf.BusinessIsLoadMore) {
    //            weakSelf.BusinessIsLoadMore(NO);
    //        }
    //    }];
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        if (weakSelf.BusinessIsLoadMore) {
    //            weakSelf.BusinessIsLoadMore(YES);
    //        }
    //    }];
    //
    
    
    
    
    
}


- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    self.label2.text = [NSString stringWithFormat:@"价格(%@)",[JYDefaultDataModel sharedDefaultData].coinPayName];
    self.label3.text = [NSString stringWithFormat:@"数量(%@)",[JYDefaultDataModel sharedDefaultData].coinBaseName];
    [self.tableView reloadData];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[JYBusinessDetailCell class] forCellReuseIdentifier:@"JYBusinessDetailCell"];
        
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    JYBusinessDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYBusinessDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    
    return cell;
    
}

@end
