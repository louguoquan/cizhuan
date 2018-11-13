//
//  JJBuyCoinViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinViewController.h"
#import "JJBuyCoinNextStepViewController.h"
#import "JJBuyCoinPageViewController.h"

@interface JJBuyCoinViewController ()

@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIButton *buyCoinBtn;

@end

@implementation JJBuyCoinViewController

- (void)viewWillAppear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"兑换";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"兑换记录" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    JJBuyCoinPageViewController *vc = [[JJBuyCoinPageViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)nextView:(UIButton *)btn{
    
    JJBuyCoinNextStepViewController *vc = [[JJBuyCoinNextStepViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self.containerView addSubview:self.bgImageView];
    [self.containerView addSubview:self.buyCoinBtn];
    
    
//   UIImage *img = [UIImage imageNamed:@"rengouBG"];
//    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.equalTo(self.containerView);
//        make.height.mas_offset(img.size.height*(kScreenWidth/img.size.width));
//    }];
    

    
    [self query];
}

- (void)query{
    
    
    [JJCalculateService JJImageCompletion:^(id result, id error) {
    
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:result[@"result"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.left.equalTo(self.containerView);
                make.height.mas_offset(image.size.height*(kScreenWidth/image.size.width));
            }];
            
            [self.buyCoinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bgImageView.mas_bottom).offset(30);
                make.height.mas_offset(40);
                make.width.mas_offset(kScreenWidth-80);
                make.centerX.equalTo(self.containerView);
                make.bottom.equalTo(self.containerView).offset(-20);
            }];
            
        }];
    }];
    
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"rengouBG"];
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}

- (UIButton *)buyCoinBtn
{
    if (!_buyCoinBtn) {
        _buyCoinBtn = [[UIButton alloc]init];
        _buyCoinBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_buyCoinBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_buyCoinBtn setBackgroundColor:GoldColor];
        _buyCoinBtn.layer.cornerRadius = 3.0f;
        _buyCoinBtn.layer.masksToBounds = YES;
        [_buyCoinBtn setTitle:@"兑换" forState:UIControlStateNormal];
        [_buyCoinBtn addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyCoinBtn;
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
