//
//  JJHomeViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJHomeViewController.h"
#import "JJHomeCell.h"
#import "JYWebController.h"
#import "JJHomeSecoundCell.h"
#import "JJShopViewController.h"
#import "JJCooperationViewController.h"
#import "JJNoteListViewController.h"
#import "TXScrollLabelView.h"

@interface JJHomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,TXScrollLabelViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataArrM;

@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UIImageView *img1;
@property (nonatomic,strong)JJHomeBaseModel *model;

@property (nonatomic,strong) UIView *BG;

@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView;
@property (nonatomic, strong) NSString *downUrl;
@property (nonatomic, strong) NSString *downUrl1;
@end


@implementation JJHomeViewController



- (void)viewDidLoad {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setUpNav];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 340)];
    self.tableView.tableHeaderView = head;
    
    
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,230) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.autoScrollTimeInterval = 2.5f;
    [head addSubview:_cycleScrollView];
    

    
//    _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
//    _img.image = [UIImage imageNamed:@"banner"];
//    _img.contentMode = UIViewContentModeScaleAspectFill;
//    _img.layer.masksToBounds = YES;
//    [head addSubview:_img];
    
    _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 230, kScreenWidth, 70)];
    _img1.image = [UIImage imageNamed:@"whitePage"];
    _img1.contentMode = UIViewContentModeScaleAspectFill;
    _img1.layer.masksToBounds = YES;
    [head addSubview:_img1];
    
    
    _BG = [[UIView alloc]initWithFrame:CGRectMake(0, 300, kScreenWidth, 40)];
    [head addSubview: _BG];
    _BG.backgroundColor = [UIColor whiteColor];
    //
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
        _BG.userInteractionEnabled = YES;
        [_BG addGestureRecognizer:tap2];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 20, 15)];
    imageView1.image = [UIImage imageNamed:@"Volume"];
    [_BG addSubview:imageView1];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#E3E3E5");
    [_BG addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_BG);
        make.height.mas_offset(1);
    }];
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    _img.userInteractionEnabled = YES;
//    [_img addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    _img1.userInteractionEnabled = YES;
    [_img1 addGestureRecognizer:tap1];
    
    
    [self query];
    [self query1];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf query];
    }];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

- (void)query1{
    [JJFoundService JJDownloadAddressCompletion:^(id result, id error) {
        NSDictionary *dic = result[@"result"];
        self.downUrl = dic[@"ios"];
    }];

    [JJFoundService JJDownloadCompletion:^(id result, id error) {
        NSDictionary *dic = result[@"result"];
        self.downUrl1 = dic[@"IOS"];
    }];
}


- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index
{
    
    JJNoteListViewController *vc = [[JJNoteListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)tap2:(UITapGestureRecognizer *)tap{
    
    
    JJNoteListViewController *vc = [[JJNoteListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    JJHomeModel *model = self.model.broadcast[index];
    if (model.url.length>0) {
        JYWebController *vc = [[JYWebController alloc]init];
        vc.urlString = model.url;
        vc.navTitle = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (void)tap1:(UITapGestureRecognizer *)tap{
    
    JJHomeModel *model = [self.model.whitepaper lastObject];
    if (model.url.length>0) {
        JYWebController *vc = [[JYWebController alloc]init];
        vc.urlString = model.url;
        vc.navTitle = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)query{
    
    
    [JJFoundService JJMobileCmsConsultationCompletion:^(id result, id error) {
        self.model = result;
        
        NSMutableArray *imgArr = [NSMutableArray array];
        if (self.model.broadcast.count>0) {
            for (JJHomeModel *model in self.model.broadcast) {
                [imgArr addObject:model.image];
            }
            
        }
        [_cycleScrollView setImageURLStringsGroup:imgArr];
        JJHomeModel *model1 = [self.model.whitepaper lastObject];
        [_img1 sd_setImageWithURL:[NSURL URLWithString:model1.image]];
        
        
    }];
    
    [JJFoundService JJMobileCmsNoticeCompletion:^(id result, id error) {
        self.dataArrM = result;
        
        
        if (self.dataArrM.count>0) {
            
            JJHomeModel *model = [self.dataArrM firstObject];
            
            /** Step1: 滚动文字 */
            NSString *scrollTitle = model.title;
            
            TXScrollLabelView *scrollLabelView = nil;
            
            /** Step2: 创建 ScrollLabelView */
            scrollLabelView = [TXScrollLabelView scrollWithTitle:scrollTitle type:TXScrollLabelViewTypeLeftRight velocity:0.8 options:UIViewAnimationOptionCurveEaseInOut];
            
            /** Step3: 设置代理进行回调(Optional) */
            scrollLabelView.scrollLabelViewDelegate = self;
            scrollLabelView.frame = CGRectMake(65, 5, kScreenWidth-80, 30);
            scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
            scrollLabelView.scrollTitleColor = HEX_COLOR(@"#666666");
            scrollLabelView.scrollSpace = 100;
            scrollLabelView.font = [UIFont systemFontOfSize:13];
            scrollLabelView.textAlignment = NSTextAlignmentCenter;
            scrollLabelView.backgroundColor = [UIColor whiteColor];
            [_BG addSubview:scrollLabelView];
            /** Step5: 开始滚动(Start scrolling!) */
            [scrollLabelView beginScrolling];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"机界";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
//        return self.dataArrM.count;
        return 1;
        
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
//        JJHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJHomeCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if (self.dataArrM.count) {
//            JJHomeModel *model = self.dataArrM[indexPath.row];
//            cell.model = model;
//        }
//        return cell;
        
        JJHomeSecoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJHomeSecoundCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.HomeSecoundClick = ^(NSInteger index) {
            
            if (index == 1) {
                JJShopViewController *vc = [[JJShopViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (index == 0){
                //跳转机界狗
                
                NSString * UrlStr = [NSString stringWithFormat:@"com.mach.game://"];
                
                NSURL * url = [NSURL URLWithString:UrlStr];
                
                // 在这里可以先做个判断
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    
                    [[UIApplication sharedApplication]openURL:url];
                    
                }else{
                    
                    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"跳转的应用程序未安装,是否跳转到安装下载页" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"跳转", MMItemTypeHighlight, ^(NSInteger index) {
                        
                        if (index == 1) {
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downUrl]];
                        }
                    
                    })]];
                    [alertView show];
              
                }
                
                
            }else if (index == 2){
                
                MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"暂未开放" items:@[MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
                    
                })]];
                [alertView show];
            }
            
        };
        if (self.dataArrM.count) {
            //        JJHomeModel *model = self.dataArrM[indexPath.row];
            cell.dataArray =[NSMutableArray arrayWithArray: @[@[@"jijiegou",@"jiqiwakuang",@"yububao"],@[@"机界狗",@"机器挖矿",@"余币宝"]]];
        }
        return cell;
    }
    JJHomeSecoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJHomeSecoundCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.HomeSecoundClick = ^(NSInteger index) {
      
        if (index == 1) {
            JJCooperationViewController *vc = [[JJCooperationViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 0){
            
            
            NSString * UrlStr = [NSString stringWithFormat:@"coinaone://"];
            
            NSURL * url = [NSURL URLWithString:UrlStr];
            
            // 在这里可以先做个判断
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
                
            }else{
                
                MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"跳转的应用程序未安装,是否跳转到安装下载页" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"跳转", MMItemTypeHighlight, ^(NSInteger index) {
                    
                    if (index == 1) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downUrl1]];
                    }
                    
                })]];
                [alertView show];
                
            }
            
        }
        else{
            MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"暂未开放" items:@[MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
                
            })]];
            [alertView show];
        }
        
    };
    if (self.dataArrM.count) {
//        JJHomeModel *model = self.dataArrM[indexPath.row];
        cell.dataArray =[NSMutableArray arrayWithArray: @[@[@"coinone",@"hezuo",@"yijianfabu"],@[@"CoinOne",@"合作入驻",@"一键发币"]]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        JJHomeModel *model = self.dataArrM[indexPath.row];
        if (model.url.length>0) {
            JYWebController *vc = [[JYWebController alloc]init];
            vc.urlString = model.url;
            vc.navTitle = model.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    bgView.backgroundColor = HEX_COLOR(@"#F8F8F8");
    
    
    NSArray *titleArray = @[@"热门应用",@"工具"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:view];

    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = GoldColor;
//    img.image = [UIImage imageNamed:@"notice"];
    label.text = titleArray[section];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.bottom.equalTo(view).offset(-10);
        make.left.equalTo(view).offset(10);
//        make.width.mas_offset(40);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#E3E3E5");
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_offset(1);
    }];
    return bgView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 60;
        
        [_tableView registerClass:[JJHomeCell class] forCellReuseIdentifier:@"JJHomeCell"];
          [_tableView registerClass:[JJHomeSecoundCell class] forCellReuseIdentifier:@"JJHomeSecoundCell"];
    }
    return _tableView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:kPlaceholderImage];
#warning 轮播图不自动滚动
        _cycleScrollView.autoScroll = YES;
    }
    return _cycleScrollView;
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
