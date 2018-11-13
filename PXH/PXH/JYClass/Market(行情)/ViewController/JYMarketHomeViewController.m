//
//  JYMarketHomeViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "JYMarketHomeViewController.h"
#import "JYUSDTOrBTCListViewController.h"
#import "JYEditOptionalViewController.h"
#import "JYMarketAdvertiseView.h"
#import "JYAdvertiseListViewController.h"
#import "YCXMenu.h"
#import "LrdOutputView.h"


#import "JYAsyncSocket.h"

#import "JYMineService.h"
#import "JYCmsIndexModel.h"


@interface JYMarketHomeViewController ()<LrdOutputViewDelegate>

@property (nonatomic, weak) UIImageView *lineView;
@property (nonatomic,strong) UIButton *collectBtn;
@property (nonatomic,strong)UILabel *navigationLabel;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) LrdOutputView *outputView;

@property (nonatomic, strong) NSMutableArray *currentArr;

@property (nonatomic,strong)LrdCellModel *model;


@end

@implementation JYMarketHomeViewController


//视图将要显示时隐藏
- (void)viewWillAppear:(BOOL)animated
{
    _lineView.hidden = YES;
    
    //夜间模式
    self.dk_manager.themeVersion = DKThemeVersionNormal;
    self.segmentView.containerView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    
}


- (NSMutableArray *)currentArr
{
    if (!_currentArr) {
        _currentArr = [NSMutableArray array];
    }
    return _currentArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

//视图将要消失时取消隐藏
- (void)viewWillDisappear:(BOOL)animated
{
    _lineView.hidden = NO;
}

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.title = @"行情";
    [self renderUI];
    //获取导航栏下面黑线
    _lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _navigationLabel;
    
    
    _collectBtn = [[UIButton alloc]init];
    _collectBtn.frame = CGRectMake(0, 0, 35, 35);
    _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(6.5, 6.5, 6.5, 6.5);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_collectBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 35, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    if (self.typeTitle) {
        
        
        _navigationLabel.text = self.typeTitle;
        
        [_collectBtn setImage:[UIImage imageNamed:@"JY_close_01"] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        [selectBtn setImage:[UIImage imageNamed:@"JY_search"] forState:UIControlStateNormal];
        selectBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        [selectBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];

    }else{
        
        
        _navigationLabel.text = @"行情";
        
        [_collectBtn setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(editOptional) forControlEvents:UIControlEventTouchUpInside];
        
        [selectBtn setImage:[UIImage imageNamed:@"shangxia"] forState:UIControlStateNormal];
        selectBtn.imageEdgeInsets = UIEdgeInsetsMake(6.5, 8, 6.5, 8);
        [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
        
        //底部的公告界面
        [self getListInfo:NO];
    }
    

    
    
    
    
    for (int i = 0; i<3; i++) {
        
        LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"按成交量排序" imageName:@"arror_nomal" index:[NSString stringWithFormat:@"%d",i]];
        LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"按价格排序" imageName:@"arror_nomal" index:[NSString stringWithFormat:@"%d",i]];
        LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"按涨幅排序" imageName:@"arror_nomal" index:[NSString stringWithFormat:@"%d",i]];
        
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:one];
        [array addObject:two];
        [array addObject:three];
        
        [self.dataArr addObject:[array mutableCopy]];

    }
    
    _currentArr = self.dataArr[0];
    
    
    _navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSelectedIndex:1 animated:NO];
    });
    

    //        UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
    //        normalItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    //        UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"Night" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
    //        nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    //        self.navigationItem.rightBarButtonItems = @[normalItem, nightItem];
    
    
    JYAsyncSocket *socket = [JYAsyncSocket shareAsncSocket];
    [socket connecteServerWith:@"192.168.0.112" onPort:2222];
    [socket sendDataWithType:1
                     withDic:@{@"1212":@"12121"}];
    [socket reciveData:^(NSString  *data, NSString *type) {
        
        
    }];
}


- (void)selctViewShow:(UIButton *)btn{
    
    
    CGFloat x = kScreenWidth-15;
    CGFloat y = btn.frame.origin.y + btn.bounds.size.height + 30;
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.currentArr origin:CGPointMake(x, y) width:125 height:44 direction:kLrdOutputViewDirectionRight];
    
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];
    

}


- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    

    for (LrdCellModel *model in self.currentArr) {
        if (![model.imageName isEqualToString:@"arror_nomal"]) {
            self.model = model;
        }
    }

    LrdCellModel *model = self.currentArr[indexPath.row];
    
    if (self.model!=model) {
        self.model.imageName = @"arror_nomal";
    }
    
    if ([model.imageName isEqualToString:@"arror_nomal"]) {
        model.imageName = @"arror_red";
    }else if ([model.imageName isEqualToString:@"arror_red"]){
         model.imageName = @"arror_green";
    }else if ([model.imageName isEqualToString:@"arror_green"]){
         model.imageName = @"arror_nomal";
    }
    _outputView.dataArray = self.dataArr;
    [_outputView.tableView reloadData];
    

    [[NSNotificationCenter defaultCenter]postNotificationName:@"SelectStatusChange" object:nil userInfo:@{@"model":model}];
}


- (void)setAdvertiseView:(JYCmsIndexModel *)adverModel {
    
    //底部的公告界面
    
    JYMarketAdvertiseView *advertiseView = [[JYMarketAdvertiseView alloc]init];
    [self.view addSubview:advertiseView];
    advertiseView.model = adverModel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToAdverList)];
    [advertiseView addGestureRecognizer:tap];
    
    
    [advertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(39);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(39);
    }];
    [advertiseView.superview layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
    
    
    advertiseView.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        
        [advertiseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
        advertiseView.alpha = 1.0;
        [advertiseView.superview layoutIfNeeded];//强制绘制
        
    }];
    
    
    [advertiseView.superview layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
    
    advertiseView.AdvertiseViewHide = ^{
        
        advertiseView.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            
            [advertiseView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(39);
            }];
            advertiseView.alpha = 0.0;
            [advertiseView.superview layoutIfNeeded];//强制绘制
            
        } completion:^(BOOL finished) {
            if (finished) {
                [advertiseView removeFromSuperview];
            }
        }];
    };
 
}


- (void)close{
    
    [JYDefaultDataModel sharedDefaultData].isHomeCome = @"NO";
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)search{
    //跳转到搜索页面
    
    
    
    
}


//跳转到广告列表
- (void)tapToAdverList{
    
    JYAdvertiseListViewController *vc = [[JYAdvertiseListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//跳转到自选编辑
- (void)editOptional{
    
    JYEditOptionalViewController *vc = [[JYEditOptionalViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 切换夜间模式代理

- (void)night {
    self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)normal {
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}


- (void)change {
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [self.dk_manager dawnComing];
    } else {
        [self.dk_manager nightFalling];
    }
}



#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    return [JYUSDTOrBTCListViewController class];
    
}

//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index{
    
 
    
    if (self.dataArr.count) {
        self.currentArr = self.dataArr[index];
        [_outputView.tableView reloadData];
    }
    
    
    if (self.typeTitle) {
    
        return @{@"index":[NSString stringWithFormat:@"%ld",index]};
        
    }
    
    switch (index) {
        case 0:
            _collectBtn.hidden = NO;
            if ([JYAccountModel sharedAccount].token.length>0) {
                //自选
                [[NSNotificationCenter defaultCenter]postNotificationName:@"editChangeRefreshData" object:nil];
            }
            break;
        default:
            _collectBtn.hidden = YES;
            break;
    }
    return @{@"index":[NSString stringWithFormat:@"%ld",index]};
    
}

- (NSArray *)titlesForPageViewController {
    return @[@"自选", @"USDT",@"BTC"];
}



#pragma mark ----- < Request >  -----

//公告
- (void)getListInfo:(BOOL)isMore
{
    WS(weakSelf)
    [JYMineService cmsIndexListWithId:@"2" page:0 completion:^(id result, id error) {
        NSArray *arr = (NSArray *)result;
        if (arr.count) {
            JYCmsIndexModel *model = arr[0];
            [weakSelf setAdvertiseView:model];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
