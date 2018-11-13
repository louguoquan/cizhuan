//
//  JYBuyTableView.m
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBuyTableView.h"
#import "JYBuyOrderListCell.h"

#import "JYAssetsService.h"

@interface JYBuyTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *headView;

@property (nonatomic,strong)UIButton *currentBtn;
@end

@implementation JYBuyTableView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    [self addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    
    NSArray *titleArray = @[@"未完成",@"待审核",@"已完成",@"已取消"];
    
    
    UIButton *lastBtn;
    
    for (int i = 0; i<4; i++) {
        
        UIButton *btn = [UIButton new];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnNomal) forState:UIControlStateNormal];
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsRed) forState:UIControlStateSelected];
        btn.tag = 400+i;
        [btn addTarget:self action:@selector(queryOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.headView);
            make.width.mas_equalTo(kScreenWidth/4.0);
            if (lastBtn) {
                   make.left.equalTo(lastBtn.mas_right);
            }else{
                   make.left.equalTo(self.headView);
            }
            make.height.mas_equalTo(25);
        }];
        
        if (i == 0) {
            self.currentBtn = btn;
            self.currentBtn.selected = YES;
        }
        
        lastBtn = btn;
    }
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.tableView reloadData];
}

- (void)queryOrder:(UIButton *)btn{
    
    if (btn != self.currentBtn) {
        
        self.currentBtn.selected = !self.currentBtn.selected;
        btn.selected = !btn.selected;
        self.currentBtn = btn;
    }
    
    
    if (self.ClickBtnWithStatus) {
        self.ClickBtnWithStatus(btn.tag-400);
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JYBuyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYBuyOrderListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count>0) {
        JYBuyOrderListModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        
        cell.OrderPayCancel = ^{
            //取消订单
            NSLog(@"取消订单");
            
            [JYAssetsService fetchCancelOrderWithOrderId:model.ID completion:^(id result, id error) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"orderStatusChange" object:self userInfo:@{@"status":@"cancel"}];
            }];
        };
        
        cell.OrderPaySuccess = ^{
            //完成付款
            NSLog(@"完成付款");
            
            [JYAssetsService fetchPayOrderWithOrderId:model.ID completion:^(id result, id error) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"orderStatusChange" object:self userInfo:@{@"status":@"deal"}];
                
            }];

            
        };

    }
    return cell;
    
}



- (UIView *)headView
{
    if (!_headView) {
        _headView = [UIView new];
        _headView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBG);
    }
    return _headView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYBuyOrderListCell class] forCellReuseIdentifier:@"JYBuyOrderListCell"];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
