//
//  JYTradingManagerViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingManagerViewController.h"
#import "JYBuyOrSaleViewController.h"
#import "JYTradingOrderListViewController.h"
#import "JYKLineViewController.h"
#import "JYMarketHomeViewController.h"
#import "JYTradingService.h"



@interface JYTradingManagerViewController ()

@property (nonatomic, weak) UIImageView *lineView;
@property (nonatomic,strong) UIButton *collectBtn;
@property (nonatomic,strong)UILabel *navigationLabel;

@property (nonatomic,strong)JYDefaultDataModel *model;

@end

@implementation JYTradingManagerViewController

//视图将要显示时隐藏
- (void)viewWillAppear:(BOOL)animated
{
    _lineView.hidden = YES;
    
    //夜间模式
    self.dk_manager.themeVersion = DKThemeVersionNormal;
    self.segmentView.containerView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    
    
    JYDefaultDataModel *model = [JYDefaultDataModel sharedDefaultData];
    self.navigationLabel.text =[NSString stringWithFormat:@"%@/%@",model.coinBaseName,model.coinPayName];
    
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

-(UILabel *)navigationLabel
{
    if (!_navigationLabel) {
        _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        
        _navigationLabel.textAlignment = NSTextAlignmentCenter;
        _navigationLabel.font = [UIFont systemFontOfSize:18];
    }
    return _navigationLabel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.title = @"行情";
    [self renderUI];
    //获取导航栏下面黑线
    _lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    
    
    self.navigationItem.titleView = self.navigationLabel;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(select)];
    self.navigationLabel.userInteractionEnabled = YES;
    [self.navigationLabel addGestureRecognizer:tap];
    
    
    _collectBtn = [[UIButton alloc]init];
    [_collectBtn setImage:[UIImage imageNamed:@"StarAdd"] forState:UIControlStateNormal];
    [_collectBtn setImage:[UIImage imageNamed:@"StarSelect"] forState:UIControlStateSelected];
    _collectBtn.frame = CGRectMake(0, 0, 35, 35);
    _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(6.5, 6.5, 6.5, 6.5);
    [_collectBtn addTarget:self action:@selector(addCollect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_collectBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"zhexian"] forState:UIControlStateNormal];
    selectBtn.frame = CGRectMake(0, 0, 35, 35);
    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(6.5, 8, 6.5, 8);
    [selectBtn addTarget:self action:@selector(gotoKline) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToBuyOrSale:) name:@"backToBuyOrSale" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postHomeData:) name:@"postHomeData" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isCollect:) name:@"isCollect" object:nil];
    
}

- (void)isCollect:(NSNotification *)noti{
    
    if ([noti.userInfo[@"isCollect"] integerValue] == 1) {
        self.collectBtn.selected = YES;
    }else{
        self.collectBtn.selected = NO;
    }
    
}

- (void)postHomeData:(NSNotification *)noti{
    
    self.model = noti.userInfo[@"model"];
    self.navigationLabel.text =[NSString stringWithFormat:@"%@/%@",self.model.coinBaseName,self.model.coinPayName];
    
    if (self.model.status.integerValue == 1) {
        _collectBtn.selected = YES;
    }else{
        _collectBtn.selected = NO;
    }
    
}


- (void)backToBuyOrSale:(NSNotification *)noti{
    
    NSDictionary *dict = noti.userInfo;
    
    if ([dict[@"status"] isEqualToString:@"buy"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSelectedIndex:0 animated:NO];
        });
        
    }else if ([dict[@"status"] isEqualToString:@"sale"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSelectedIndex:1 animated:NO];
        });
        
    }
    
    
}


- (void)select{
    
    
    JYMarketHomeViewController *vc = [[JYMarketHomeViewController alloc] init];
    vc.typeTitle = [NSString stringWithFormat:@"%@/%@",[JYDefaultDataModel sharedDefaultData].coinBaseName,[JYDefaultDataModel sharedDefaultData].coinPayName];
    [JYDefaultDataModel sharedDefaultData].isHomeCome = @"YES";
    YSNavigationController *nav = [[YSNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)addCollect:(UIButton *)btn{
    
    if (btn.selected) {
        //解除收藏
        [JYTradingService fetchCollectCoinByID:[JYDefaultDataModel sharedDefaultData].coinBaseID type:@"1" sourceType:[JYDefaultDataModel sharedDefaultData].coinPayID completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"取消收藏成功" toContainer:self.view];
        }];
        
    }else{
        //添加收藏
        [JYTradingService fetchCollectCoinByID:[JYDefaultDataModel sharedDefaultData].coinBaseID type:@"0" sourceType:[JYDefaultDataModel sharedDefaultData].coinPayID completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"收藏成功" toContainer:self.view];
        }];
    }
    
    
    //添加到自选
    btn.selected = !btn.selected;
    
    
    
    
    
}



- (void)gotoKline{
    //跳转到K线图界面
    
    JYKLineViewController *vc = [[JYKLineViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}




#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            return [JYBuyOrSaleViewController class];
            break;
        case 1:
            return [JYBuyOrSaleViewController class];
            break;
            
        default:
            break;
    }
    
    return [JYTradingOrderListViewController class];
    
}


//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index{
    
    
    if (index>1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TradingOrderListRefreshData" object:self userInfo:@{}];
    }
    
    return @{@"index":[NSString stringWithFormat:@"%ld",index]};
}

- (NSArray *)titlesForPageViewController {
    return @[@"买入", @"卖出",@"当前委托",@"历史成交",@"历史委托"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
