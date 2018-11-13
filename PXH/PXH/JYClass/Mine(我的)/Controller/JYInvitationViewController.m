//
//  JYInvitationViewController.m
//  PXH
//
//  Created by louguoquan on 2018/6/7.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYInvitationViewController.h"
#import "JYInvitationCell.h"
#import "JYEarningsViewController.h"


@interface JYInvitationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bottiomView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *peopleCountLabel;
@property (nonatomic,strong)UILabel *usdtCountLabel;
@property (nonatomic,strong)UILabel *btcCountLabel;
@property (nonatomic,strong)UILabel *codeLabel;


@end

@implementation JYInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"邀请好友";
    
    CGFloat heightNomal = (kScreenHeight/667.0);
    self.view.backgroundColor = HEX_COLOR(@"#EFEFF6");
    [self.containerView addSubview:self.topView];
    [self.view addSubview:self.bottiomView];
    [self.view addSubview:self.tableView];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(190*heightNomal);
    }];
    
    UIView *top = [UIView new];
    [self.topView addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.topView);
        make.height.mas_offset(90*heightNomal);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"我的收益";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = HEX_COLOR(@"#000000");
    [top addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(top).offset(15);
        make.height.mas_offset(30*heightNomal);
    }];
    
    UILabel *subLabel = [UILabel new];
    subLabel.text = @"邀请好友可获得手续费50%返佣";
    subLabel.font = [UIFont systemFontOfSize:15];
    subLabel.textColor = HEX_COLOR(@"#666666");
    [top addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(titleLabel);
        make.height.mas_offset(14*heightNomal);
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"rightArror"];
    [top addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(top);
        make.right.equalTo(top).offset(-15);
        make.width.height.mas_offset(25);
    }];
    
    UIView *line = [UIView new];
//    line.backgroundColor = HEX_COLOR(@"#F0F1F3");
    line.backgroundColor = [UIColor whiteColor];
    [top addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(top);
        make.left.equalTo(top).offset(10);
        make.right.equalTo(top).offset(-10);
        make.height.mas_offset(1);
    }];
    
    self.topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToList:)];
    [self.topView addGestureRecognizer:tap];
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"邀请人数";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = HEX_COLOR(@"#666666");
    [self.topView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(15);
        make.left.equalTo(self.topView).offset(15);
        make.height.mas_offset(12*heightNomal);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"USDT";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = HEX_COLOR(@"#666666");
    [self.topView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(15);
        make.centerX.equalTo(self.topView);
        make.height.mas_offset(12*heightNomal);
    }];
    
    
    UILabel *label3 = [UILabel new];
    label3.text = @"BTC";
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = HEX_COLOR(@"#666666");
    [self.topView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(15);
        make.right.equalTo(self.topView).offset(-15);
        make.height.mas_offset(12*heightNomal);
    }];
    
    
    [self.topView addSubview:self.peopleCountLabel];
    [self.topView addSubview:self.btcCountLabel];
    [self.topView addSubview:self.usdtCountLabel];
    
    [self.peopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1);
        make.top.equalTo(label1.mas_bottom).offset(5);
        make.height.mas_offset(15*heightNomal);
    }];
    
    [self.usdtCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label2);
        make.top.equalTo(label2.mas_bottom).offset(5);
        make.height.mas_offset(15*heightNomal);
    }];

    
    [self.btcCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label3);
        make.top.equalTo(label3.mas_bottom).offset(5);
        make.height.mas_offset(15*heightNomal);
    }];
    
    
    UIView *bottom = [UIView new];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.bottom.equalTo(self.topView);
        make.height.mas_offset(40*heightNomal);
        make.bottom.equalTo(self.containerView).offset(-1);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.image = [UIImage imageNamed:@"01"];
    [bottom addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottom).offset(10);
        make.centerY.equalTo(bottom);
        make.width.mas_offset(20);
        make.height.mas_offset(25);
    }];
    
    
    UILabel *label4 = [UILabel new];
    label4.text = @"邀请排行榜";
    label4.font = [UIFont systemFontOfSize:14];
    label4.textColor = HEX_COLOR(@"#222222");
    [bottom addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottom);
        make.left.equalTo(imageView1.mas_right).offset(5);
        make.height.mas_offset(15*heightNomal);
    }];
    
    
    UILabel *label5 = [UILabel new];
    label5.text = @"查看完整榜单 >";
    label5.font = [UIFont systemFontOfSize:12];
    label5.dk_textColorPicker = DKColorPickerWithKey(ShareViewBULE);
    [bottom addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottom);
        make.right.equalTo(bottom).offset(-15);
        make.height.mas_offset(15*heightNomal);
    }];
    
    
    
    [self.bottiomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(110*heightNomal);
    }];
    
    self.bottiomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label6 = [UILabel new];
    label6.text = @"邀请码";
    label6.font = [UIFont systemFontOfSize:15];
    label6.textColor = HEX_COLOR(@"#666666");
    [self.bottiomView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottiomView).offset(15);
        make.left.equalTo(self.bottiomView).offset(15);
        make.height.mas_offset(15*heightNomal);
    }];
    
    [self.bottiomView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label6.mas_right).offset(5);
        make.height.mas_equalTo(15*heightNomal);
        make.top.equalTo(label6);
    }];
    
    UILabel *label7 = [UILabel new];
    label7.text = @"复制";
    label7.textAlignment = NSTextAlignmentCenter;
    label7.font = [UIFont systemFontOfSize:15];
    label7.dk_backgroundColorPicker = DKColorPickerWithKey(CopyBG);
    label7.dk_textColorPicker = DKColorPickerWithKey(CopyTexT);
    [self.bottiomView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottiomView).offset(15);
        make.right.equalTo(self.bottiomView).offset(-15);
        make.height.mas_offset(30*heightNomal);
        make.width.mas_equalTo(50);
    }];
    label7.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyStr)];
    [label7 addGestureRecognizer:tap1];
    
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"立即邀请" forState:UIControlStateNormal];
    btn.dk_backgroundColorPicker = DKColorPickerWithKey(ShareViewBULE);
    [btn addTarget:self action:@selector(gotoShare:) forControlEvents:UIControlEventTouchUpInside];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(CopyTexT) forState:UIControlStateNormal];
    [self.bottiomView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottiomView).offset(15);
        make.right.equalTo(self.bottiomView).offset(-15);
        make.bottom.equalTo(self.bottiomView).offset(-15);
        make.height.mas_equalTo(40*heightNomal);
    }];
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-110*heightNomal);
    }];
    
    
    
    
    
    
    
    self.codeLabel.text = @"pur85";
    
    self.peopleCountLabel.text = @"8";
    self.usdtCountLabel.text = @"229.88888";
    self.btcCountLabel.text = @"0.000000012312";
    
    
    [self createNav];
}

- (void)createNav{
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"规则" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoRule:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYInvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYInvitationCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = @"1";
    return cell;
}

- (void)tapToList:(UITapGestureRecognizer*)tap{
    
    JYEarningsViewController *vc = [[JYEarningsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)gotoRule:(UIButton *)btn{
    
    
    
}

- (void)gotoShare:(UIButton *)btn{
    
    
    
}

- (void)copyStr{
    
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.codeLabel.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
    
}


- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

- (UILabel *)peopleCountLabel
{
    if (!_peopleCountLabel) {
        _peopleCountLabel = [UILabel new];
        _peopleCountLabel.font = [UIFont systemFontOfSize:15];
        _peopleCountLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _peopleCountLabel;
}

- (UILabel *)usdtCountLabel
{
    if (!_usdtCountLabel) {
        _usdtCountLabel = [UILabel new];
        _usdtCountLabel.font = [UIFont systemFontOfSize:15];
        _usdtCountLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _usdtCountLabel;
}


- (UILabel *)btcCountLabel
{
    if (!_btcCountLabel) {
        _btcCountLabel = [UILabel new];
        _btcCountLabel.font = [UIFont systemFontOfSize:15];
        _btcCountLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _btcCountLabel;
}


- (UIView *)bottiomView
{
    if (!_bottiomView) {
        _bottiomView = [[UIView alloc]init];
        
    }
    return _bottiomView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYInvitationCell class] forCellReuseIdentifier:@"JYInvitationCell"];
        
    }
    return _tableView;
}


- (UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [UILabel new];
        _btcCountLabel.font = [UIFont systemFontOfSize:14];
        _btcCountLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _codeLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
