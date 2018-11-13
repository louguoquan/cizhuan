//
//  JYWithdrawalView.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYWithdrawalView.h"


@interface JYWithdrawalView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView  *headView;
@property (nonatomic,strong)UIView *bottomHeadView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation JYWithdrawalView


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
        make.top.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    UIView *head = [UIView new];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    
    [self.headView addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.headView);
        make.right.equalTo(self.headView);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"法币交易说明" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
    btn.tag = 200;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [head addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(head);
        make.width.mas_equalTo((kScreenWidth-20)/2.0-1);
    }];
    [btn addTarget:self action:@selector(tapToScorll:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"平台内转账" forState:UIControlStateNormal];
    [btn1 dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
    btn1.tag = 201;
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [head addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(head);
        make.width.mas_equalTo((kScreenWidth-20)/2.0-1);
    }];
    
    [btn1 addTarget:self action:@selector(tapToScorll:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self addSubview:self.messageView];
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom);
        make.left.equalTo(self.headView);
        make.width.mas_equalTo(kScreenWidth-20);
        make.bottom.equalTo(self);
    }];
    
    
    
    
    [self addSubview:self.transferView];
    [self.transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom);
        make.left.equalTo(self.messageView);
        make.width.mas_equalTo(kScreenWidth-20);
        //        make.bottom.equalTo(self);
    }];
    
    self.transferView.model = @"1";
    
    [self addSubview:self.bottomHeadView];
    [self.bottomHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transferView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(25);
        
    }];
    
    _label1 = [UILabel new];
    _label1.text = @"转账记录";
    _label1.font = [UIFont systemFontOfSize:13];
    _label1.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self.bottomHeadView addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomHeadView).offset(11);
        make.top.equalTo(self.bottomHeadView).offset(5);
        make.bottom.equalTo(self.bottomHeadView).offset(-5);
    }];
    
    _label2 = [UILabel new];
    _label2.text = @"更多 > ";
    _label2.font = [UIFont systemFontOfSize:13];
    _label2.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self.bottomHeadView addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomHeadView).offset(-11);
        make.top.bottom.equalTo(self.bottomHeadView);
    }];
    
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomHeadView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    self.bottomHeadView.hidden = YES;
    self.label1.hidden = YES;
    self.label2.hidden = YES;
    
    
    
    self.tableView.hidden = YES;
    
    self.transferView.hidden = YES;
    self.messageView.hidden = NO;
    
}





- (void)tapToScorll:(UIButton *)btn{
    
    
    if (btn.tag == 200) {
        
        self.messageView.hidden = NO;
        self.transferView.hidden = YES;
        
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(self.messageView);
        }];
        
        self.bottomHeadView.hidden = YES;
        self.label1.hidden = YES;
        self.label2.hidden = YES;
        
        self.tableView.hidden = YES;
        
        
    }else if(btn.tag == 201){
        
        self.messageView.hidden = YES;
        self.transferView.hidden = NO;
        [self.transferView gainCurrencyType:NO];
        
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(self.transferView);
        }];
        
        self.bottomHeadView.hidden = NO;
        self.label1.hidden = NO;
        self.label2.hidden = NO;
        
        self.tableView.hidden = NO;
    }
}


#pragma mark - tableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYC2CRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYC2CRecordListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.model = _service.dataSource[indexPath.row];
//    cell.model = @"1";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}




- (UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.layer.cornerRadius = 4.0f;
        _headView.layer.masksToBounds = YES;
        _headView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    }
    return _headView;
}


- (JYWithdrawalMessageView *)messageView
{
    if (!_messageView) {
        _messageView = [[JYWithdrawalMessageView alloc]init];
        
    }
    return _messageView;
}


- (JYWithdrawalTransferView *)transferView
{
    if (!_transferView) {
        _transferView = [[JYWithdrawalTransferView alloc]init];
    }
    return _transferView;
    
}

- (UIView *)bottomHeadView
{
    if (!_bottomHeadView) {
        _bottomHeadView = [UIView new];
        
    }
    return _bottomHeadView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 110.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
        [_tableView registerClass:[JYC2CRecordListCell class] forCellReuseIdentifier:@"JYC2CRecordListCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
