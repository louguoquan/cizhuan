//
//  JYReceiveBenefitsController.m
//  PXH
//
//  Created by LX on 2018/6/7.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYReceiveBenefitsController.h"
#import "JYEarningsViewController.h"
#import "JYWebController.h"

#import "JYMineService.h"

#import "JYBenefitsCell.h"
#import "JYUMShareManger.h"

#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>
#import <CoreImage/CoreImage.h>

@interface JYReceiveBenefitsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView     *tableView;

@property (nonatomic, strong) UILabel       *invCodeLab;

@property (nonatomic, strong) UIButton      *invNowBtn;

@property (nonatomic, strong) JYMyProfitModel     *profitModel;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign)NSInteger page;

@end

static NSString *const BenefitsCellID = @"BenefitsCell_ID";

static NSInteger       BenefitsBase_Tag = 1000;

@implementation JYReceiveBenefitsController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self queryMyProfit];

    self.page = 1;
    
    [self queryRevenueRanking];
    
    UILabel *lab = [self.view viewWithTag:BenefitsBase_Tag+0];
    lab.text = @"0";
    
    UILabel *lab1 = [self.view viewWithTag:BenefitsBase_Tag+1];
    lab1.text = @"0";
    
    UILabel *lab2 = [self.view viewWithTag:BenefitsBase_Tag+2];
    lab2.text = @"0";
    
    self.invCodeLab.text = @"0";
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"我的邀请";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"规则" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel sizeToFit];
    [btn addTarget:self action:@selector(ruleAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)queryMyProfit{

    [JYMineService fetchMyProfitCompletion:^(id result, id error) {
        
        self.profitModel = result;
        self.invCodeLab.text = self.profitModel.recCode;
        
        UILabel *lab = [self.view viewWithTag:BenefitsBase_Tag+0];
        lab.text = self.profitModel.recNum;
        
        UILabel *lab1 = [self.view viewWithTag:BenefitsBase_Tag+1];
        lab1.text = @"0";
        
        UILabel *lab2 = [self.view viewWithTag:BenefitsBase_Tag+2];
        lab2.text = @"0";
        
    }];
    
}

- (void)queryRevenueRanking{
    if (self.page == 1) {
        self.dataArray = [NSMutableArray array];
    }
    
    [JYMineService fetchRevenueRankingWithPage:self.page completion:^(id result, id error) {
        
        self.dataArray = [NSMutableArray arrayWithArray:result];
        [self.tableView reloadData];
        
    }];
}

- (void)setUpUI
{
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = self.view.dk_backgroundColorPicker;

//headView
    
    UIView *headView = UIView.new;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkMyWinAction)];
    [headView addGestureRecognizer:tap];
    [self.view addSubview:headView];

    UILabel *winLab = [UILabel new];
    winLab.text = @"我的收益";
    winLab.textAlignment = NSTextAlignmentLeft;
    winLab.font = [UIFont systemFontOfSize:18];
    [headView addSubview:winLab];
    
    UILabel *winRefLab = [UILabel new];
    winRefLab.text = @"邀请好友可获得手续费50%返佣";
    winRefLab.textAlignment = NSTextAlignmentLeft;
    winRefLab.font = [UIFont systemFontOfSize:15];
    winRefLab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
    [headView addSubview:winRefLab];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"return"];
    [headView addSubview:imgView];
    
    UIView *lineF = [[UIView alloc] init];
    lineF.dk_backgroundColorPicker = DKColorPickerWithKey(LINE);
    [headView addSubview:lineF];
    
    WS(weakSelf)
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(170);
    }];
    
    [winLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
    }];
    
    [winRefLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(winLab.mas_bottom).mas_offset(10);
        make.left.equalTo(winLab);
    }];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(winLab.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-15);
    }];
    
    [lineF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(winRefLab.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(1);
        make.left.equalTo(winRefLab);
        make.right.equalTo(imgView);
    }];
    
    NSArray *arr = @[@"邀请人数", @"AT"];// @"USDT",
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lab = [UILabel new];
        lab.text = obj;
        lab.textAlignment = (idx==arr.count-1)?NSTextAlignmentRight:NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        lab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
        [headView addSubview:lab];
        
        UILabel *winInfolab = [UILabel new];
        winInfolab.tag = BenefitsBase_Tag + idx;
        winInfolab.text = @"0";
        winInfolab.textAlignment = (idx==arr.count-1)?NSTextAlignmentRight:NSTextAlignmentLeft;
        winInfolab.font = [UIFont systemFontOfSize:16];
        [headView addSubview:winInfolab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineF.mas_bottom).mas_offset(20);
            make.width.mas_equalTo((kScreenWidth-30)/2);
            make.left.mas_equalTo(15+(kScreenWidth-30)/2 * idx);
        }];
        
        [winInfolab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lab.mas_bottom).mas_offset(10);
            make.left.width.equalTo(lab);
        }];
    }];

    
    UIView *bottomView = UIView.new;
    UITapGestureRecognizer *bottomtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkListAction)];
    [bottomView addGestureRecognizer:bottomtap];
    [self.view addSubview:bottomView];
    bottomView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    UIImageView *bottomImgView = [[UIImageView alloc] init];
    bottomImgView.image = [UIImage imageNamed:@"benefits_list"];
    [bottomView addSubview:bottomImgView];
    
    UILabel *titlelab = [UILabel new];
    titlelab.text = @"邀请排行榜";
    titlelab.textAlignment = NSTextAlignmentLeft;
    titlelab.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:titlelab];
    
    UILabel *checklab = [UILabel new];
    checklab.text = @"查看完整榜单 >";
    checklab.textAlignment = NSTextAlignmentRight;
    checklab.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:checklab];
    checklab.dk_textColorPicker = DKColorPickerWithKey(TRADINGStatusBG);
    
    UIView *line = [[UIView alloc] init];
    line.dk_backgroundColorPicker = DKColorPickerWithKey(LINE);
    [bottomView addSubview:line];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(45.f);
    }];
    
    [bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(20);
        make.height.equalTo(bottomImgView.mas_width).multipliedBy(1.25);
    }];
    
    [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomImgView);
        make.left.equalTo(bottomImgView.mas_right).mas_offset(5);
    }];
    
    [checklab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomImgView);
        make.right.mas_equalTo(-15);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).mas_offset(-130);
    }];
    
    
//footView
    
    UILabel *invCodeNameLab = [UILabel new];
    invCodeNameLab.text = @"邀请码：";
    invCodeNameLab.textAlignment = NSTextAlignmentLeft;
    invCodeNameLab.font = [UIFont systemFontOfSize:15];
    invCodeNameLab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
    [self.view addSubview:invCodeNameLab];
    
    [self.view addSubview:self.invCodeLab];
    
    UIButton *cloneBtn = [[UIButton alloc] init];
    cloneBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [cloneBtn setTitle:@"复制" forState:0];
    [cloneBtn addTarget:self action:@selector(cloneInvCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    cloneBtn.layer.masksToBounds = YES;
    cloneBtn.layer.cornerRadius = 5.f;
    cloneBtn.layer.borderWidth = 1.f;
//    cloneBtn.layer.dk_borderColorPicker = DKColorPickerWithKey(TRADINGStatusBG);
//    [cloneBtn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGStatusBG) forState:0];
    cloneBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.view addSubview:cloneBtn];
    
    [self.view addSubview:self.invNowBtn];
    
    [self.invNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).mas_offset(-20);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [invCodeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.invNowBtn.mas_top).mas_offset(-20);
        make.left.mas_equalTo(15.f);
    }];
    
    [self.invCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(invCodeNameLab);
        make.left.equalTo(invCodeNameLab.mas_right);
    }];
    
    [cloneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(invCodeNameLab);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(60.f);
        make.height.mas_equalTo(30.f);
    }];
}

- (void)ruleAction
{
    NSLog(@"规则");
    
    JYWebController *vc = [[JYWebController alloc] init];
    vc.urlString = @"http://web.asfinex.com/rule";
    vc.navTitle = @"规则介绍";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)checkMyWinAction
{
    NSLog(@"查看我的收益");
    
    JYEarningsViewController *vc = [[JYEarningsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)checkListAction
{
    NSLog(@"查看榜单");
    
    JYEarningsViewController *vc = [[JYEarningsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//Mark: --复制邀请码
- (void)cloneInvCodeAction:(UIButton *)sender
{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.invCodeLab.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)invNowAction:(UIButton *)sender
{
    NSLog(@"立即邀请");
    
    if ([self.invCodeLab.text isEqualToString:@"0"]) {
        [MBProgressHUD showText:@"邀请码获取失败" toContainer:nil];
        return;
    }
 
    NSString *webUrl = [NSString stringWithFormat:@"http://web.asfinex.com/share?recCode=%@", self.invCodeLab.text];
    
    NSDictionary *data = @{@"title":@"AsFinex注册邀请有奖",
                           @"descr":@"好玩的币都在这里，赶紧注册吧！",
//                           @"thumImage":@"",
                           @"weburl":webUrl,
                           };
    [[JYUMShareManger sharedManger] customWebShareWithVC:self platformType:PlatformType_All webData:data];
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYBenefitsCell *cell = [tableView dequeueReusableCellWithIdentifier:BenefitsCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    if (self.dataArray.count) {
        cell.index = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.model = self.dataArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.tableFooterView = UIView.new;
        
        _tableView.estimatedRowHeight = 70;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerClass:[JYBenefitsCell class] forCellReuseIdentifier:BenefitsCellID];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UILabel *)invCodeLab
{
    if (!_invCodeLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        
        _invCodeLab = lab;
    }
    return _invCodeLab;
}

-(UIButton *)invNowBtn
{
    if (!_invNowBtn) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [btn setTitle:@"立即邀请" forState:0];
        [btn addTarget:self action:@selector(invNowAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        btn.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGStatusBG);
        _invNowBtn = btn;
    }
    return _invNowBtn;
}


@end
