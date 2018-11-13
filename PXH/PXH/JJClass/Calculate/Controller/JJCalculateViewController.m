//
//  JJCalculateViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateViewController.h"
#import "FloatingBallHeader.h"
#import "JJStrokeLabel.h"
#import "JJCalculateCell.h"
#import "JJInvitationViewController.h"
#import "JJBuyCoinViewController.h"
#import "JJCalculateTaskViewController.h"
#import "JJMineCalculateListViewController.h"
#import "JJShopViewController.h"
#import "JJCardEditViewController.h"

// 导入系统框架
#import <AudioToolbox/AudioToolbox.h>

@interface JJCalculateViewController ()<FloatingBallHeaderDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FloatingBallHeader *floatingBallHeader;
@property (nonatomic, strong)UIImageView *shadowImage;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArrayM;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation JJCalculateViewController

#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        NSLog(@"%f", scrollView.contentOffset.y);
        CGFloat offset = scrollView.contentOffset.y;
        
        //根据透明度来生成图片
        //找最大值/
        CGFloat alpha = offset * 1 / 64;   // (200 - 64) / 136.0f
        if (alpha >= 1) {
            alpha = 0.99;
        }
        
        //        //拿到标题 标题文字的随着移动高度的变化而变化
        //        UILabel *titleL = (UILabel *)self.navigationItem.titleView;
        //        titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
        
        //把颜色生成图片
        UIColor *alphaColor = [UIColor colorWithRed:0.08 green:0.09 blue:0.15 alpha:alpha];
        //把颜色生成图片
        UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
        //修改导航条背景图片
        [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    _shadowImage.hidden = YES;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    
    
    if (self.tableView.contentOffset.y>0) {
        
        CGFloat offset = self.tableView.contentOffset.y;
        
        //根据透明度来生成图片
        //找最大值/
        CGFloat alpha = offset * 1 / 64;   // (200 - 64) / 136.0f
        if (alpha >= 1) {
            alpha = 0.99;
        }
        
        //        //拿到标题 标题文字的随着移动高度的变化而变化
        //        UILabel *titleL = (UILabel *)self.navigationItem.titleView;
        //        titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
        
        //把颜色生成图片
        UIColor *alphaColor = [UIColor colorWithRed:0.08 green:0.09 blue:0.15 alpha:alpha];
        //把颜色生成图片
        UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
        //修改导航条背景图片
        [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
        
    }
    
     [self.floatingBallHeader resetAnimation];
    
     [self queryBallWithPage:1];
    
}


- (void)queryBallWithPage:(NSInteger)page{
    
    
    self.dataArray = [NSMutableArray array];
    
    
    [JJCalculateService dayRewardWithPage:1 Completion:^(id result, id error) {
        
        JJCalculateBallBaseModel *model = result;
        
        NSArray *array =  model.dayReward;
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSInteger i = 0; i<array.count;i++ ) {
            JJCalculateBallModel *model = array[i];
            [dataArr addObject:model.reward];
        }
        
        if (model.dayReward.count == 0) {
            self.floatingBallHeader.secondsCountDown = [model.countDown longLongValue]/1000;
        }
        self.floatingBallHeader.dataList = [NSArray arrayWithArray:dataArr];
        
        self.dataArray = [NSMutableArray arrayWithArray:array];
        self.floatingBallHeader.count1 = model.MACH;
    }];
    
    [JJCalculateService counttRankingCompletion:^(id result, id error) {
        
        self.dataArrayM = [NSMutableArray arrayWithArray:result];
        [self.tableView reloadData];
    }];
    
    
    [JJCalculateService myCountCompletion:^(id result, id error) {
        self.floatingBallHeader.count = [NSString stringWithFormat:@"%@",result[@"result"]];
     
    }];
    
    
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"算力";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}


- (void)viewDidLoad {
    
    
    
    
    [self setUpNav];
    
  
    
    _shadowImage = [self makeClearNavigationController];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    FloatingBallHeader *floatingBallHeader = [[FloatingBallHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*fixHeightM)];
    floatingBallHeader.delegate = self;
//    floatingBallHeader.dataList = @[@"1.2", @"0.05", @"1.88", @"10.55", @"20", @"33", @"0.01", @"1.23"];
    self.floatingBallHeader = floatingBallHeader;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    self.floatingBallHeader.count = @"1";
    
    
    WS(weakSelf);
    self.floatingBallHeader.JJMineCalculateClick = ^{
    
        JJMineCalculateListViewController *vc = [[JJMineCalculateListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    
    self.floatingBallHeader.JJMineCalculateTimeOut = ^{
        [weakSelf queryBallWithPage:1];
    };
    
    self.tableView.tableHeaderView = self.floatingBallHeader;
    
    
    UIView *lastView;
    
    NSArray *imgArr = @[@"ts",@"yq",@"creditcard",@"rg"];
    NSArray *titleArr = @[@"提升算力",@"邀请好友",@"算力卡",@"兑换"];
    
    for (NSInteger i = 0; i<titleArr.count; i++) {
        UIView *view = [[UIView alloc]init];
        [self.floatingBallHeader addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (!lastView) {
                make.left.equalTo(self.floatingBallHeader).offset(20);
            }else
            {
                if (i!=3) {
                    make.left.equalTo(lastView.mas_right).offset(20);
                }
                else{
                    make.right.equalTo(self.floatingBallHeader).offset(-20);
                }
            }
            
            make.bottom.equalTo(self.floatingBallHeader).offset(-20);
            make.width.mas_offset((400/667.0*90)/(375.0/kScreenWidth));
            make.height.mas_offset((400/667.0*100)/(375.0/kScreenWidth));
            
        }];
        
        lastView = view;
        view.tag = 100+i;
        
        
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:imgArr[i]];
        [view addSubview:img];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(view);
            make.height.equalTo(img.mas_width);
        }];
        
        JJStrokeLabel *label = [[JJStrokeLabel alloc]init];
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumFontSize = 0.1;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = HEX_COLOR(@"#ffffff");
        //描边
        if (i == 0) {
            label.strokeColor = HEX_COLOR(@"#548AE8");
        }else if (i == 1){
            label.strokeColor = HEX_COLOR(@"#8B5FC3");
        }else if (i == 2){
            label.strokeColor = GoldColor;
        }else{
            label.strokeColor = HEX_COLOR(@"#E68445");
        }
        
        label.strokeWidth = 1;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.bottom.equalTo(view);
            make.height.mas_offset(15);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToViewController:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
    }
    
    
    
    [JYAccountModel sharedAccount].BallClick = ^(NSInteger index) {
        
        [weakSelf playVoice];
        JJCalculateBallModel *model = self.dataArray[index];
        [JJCalculateService dianYiDianWithID:model.ID Completion:^(id result, id error) {
            self.floatingBallHeader.count1 = result[@"result"];
            [JYAccountModel sharedAccount].BallClickReceive();
            
        }];
        
    };
}

- (void)playVoice{
    
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:@"9654.wav" ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
//        AudioServicesPlayAlertSound(soundID);//播放音效并震动
  
    
  
    
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    //3.销毁声音
    AudioServicesDisposeSystemSoundID(soundID);
}



- (void)tapToViewController:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag  == 100) {
        
        JJCalculateTaskViewController *vc = [[JJCalculateTaskViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (tap.view.tag == 101){
        
        JJInvitationViewController *vc = [[JJInvitationViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (tap.view.tag == 102){
        
        JJCardEditViewController *vc = [[JJCardEditViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        JJBuyCoinViewController *vc = [[JJBuyCoinViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrayM.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJCalculateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJCalculateCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArrayM.count) {
        JJCalculateModel *model = self.dataArrayM[indexPath.row];
        cell.model = model;
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"当前算力排行";
    label.textColor = GoldColor;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.centerY.equalTo(view);
        make.bottom.equalTo(view).offset(-10);
        make.top.equalTo(view).offset(10);
        
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#ECECEC");
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.bottom.equalTo(view).offset(-1);
        make.height.mas_offset(1);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne {
    NSLog(@"点了%zd", index);
    
    
  
    
    if (isLastOne) {
        // 点了最后一个，刷新
        [self queryBallWithPage:1];
    }
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 60;
        [_tableView registerClass:[JJCalculateCell class] forCellReuseIdentifier:@"JJCalculateCell"];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
