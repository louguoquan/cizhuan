//
//  YSSignInViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSignInViewController.h"
#import "YSMyIntegralViewController.h"

#import "YSButton.h"
#import "YSCalendarView.h"
#import "YSSignSuccessView.h"

@interface YSSignInViewController ()

@property (nonatomic, strong) UIButton  *signinButton;

@property (nonatomic, strong) YSCalendarView    *calendarView;

@property (nonatomic, strong) YSSigninModel     *signinModel;

@property (nonatomic, strong) UILabel   *integralLabel;

@end

@implementation YSSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"每日签到";

    [self setup];
    
    [self fetchSigninData];
    
    [self fetchJiFen];
}

- (void)fetchJiFen
{
    [YSAccountService fetchUserInfoWithCompletion:^(id result, id error) {
        _integralLabel.text = [NSString stringWithFormat:@"总积分: %zd", [YSAccount sharedAccount].score];
    }];
}

- (void)setup {
    
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = [UIImage imageNamed:@"signin_bg"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.userInteractionEnabled = YES;
    [self.containerView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(kScreenWidth * 678 / 750.0);
    }];
    
    YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
    [button setTitle:@"我的积分" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.space = 5;
    [button setImage:[UIImage imageNamed:@"signin_integral"] forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        YSMyIntegralViewController *vc = [YSMyIntegralViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    
    UIImageView *avatar = [UIImageView new];
    avatar.layer.cornerRadius = 22;
    avatar.layer.masksToBounds = YES;
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    [avatar sd_setImageWithURL:[NSURL URLWithString:[YSAccount sharedAccount].logo] placeholderImage:kPlaceholderImage];
    [self.containerView addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.width.mas_equalTo(44);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [YSAccount sharedAccount].nickName;
    [self.containerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatar);
        make.left.equalTo(avatar.mas_right).offset(10);
        make.right.equalTo(button.mas_left).offset(-10);
    }];
    
    _integralLabel = [UILabel new];
    _integralLabel.font = [UIFont systemFontOfSize:15];
    _integralLabel.textColor = [UIColor whiteColor];
//    _integralLabel.text = [NSString stringWithFormat:@"总积分: %zd", [YSAccount sharedAccount].score];
    [self.containerView addSubview:_integralLabel];
    [_integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(avatar);
        make.left.equalTo(avatar.mas_right).offset(10);
        make.right.equalTo(button.mas_left).offset(-10);
    }];

    _signinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_signinButton setBackgroundImage:[UIImage imageNamed:@"signin_buttonbg"] forState:UIControlStateNormal];
    _signinButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_signinButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [_signinButton setTitle:@"签" forState:UIControlStateNormal];
    [_signinButton setTitle:@"已签到" forState:UIControlStateSelected];
    [_signinButton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:_signinButton];
    [_signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(92);
        make.centerX.offset(0);
        make.centerY.offset(40);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [self.containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *dateLabel = [UILabel new];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = HEX_COLOR(@"#333333");
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    [self.containerView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.centerX.equalTo(self.containerView);
    }];

    UIView *lastView = nil;
    NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (NSInteger i = 0; i < 7; i ++) {
        UILabel *weekLabel = [UILabel new];
        weekLabel.text = weekArr[i];
        weekLabel.font = [UIFont systemFontOfSize:14];
        weekLabel.textColor = MAIN_COLOR;
        weekLabel.textAlignment = NSTextAlignmentCenter;
        [self.containerView addSubview:weekLabel];
        [weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.height.width.equalTo(lastView);
                make.left.equalTo(lastView.mas_right);
                if (i == 6) {
                    make.right.offset(0);
                }
            }else {
                make.top.equalTo(dateLabel.mas_bottom).offset(25);
                make.left.equalTo(self.containerView);
                make.height.equalTo(@25);
            }
        }];
        
        lastView = weekLabel;
    }

    _calendarView = [YSCalendarView new];
    [self.containerView addSubview:_calendarView];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(lastView.mas_bottom);
        make.bottom.offset(-20);
    }];
}

- (void)updateGui {
    
    _signinButton.selected = _signinModel.isTodaySign;
    
    [_calendarView setComponents:_signinModel.list];
}

- (void)fetchSigninData {
    
    [MBProgressHUD showLoadingText:@"正在获取数据" toContainer:nil];
    [YSAccountService fetchSigninDataWithCompletion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        
        _signinModel = result;
        [self updateGui];
    }];
}

- (void)signin {
    
    if (_signinModel.isTodaySign) {
        return;
    }
    
    [MBProgressHUD showLoadingText:@"正在签到" toContainer:nil];
    [YSAccountService signinWithCompletion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        
        _signinModel = result;
        [self updateGui];
        
        YSSignSuccessView *view = [[YSSignSuccessView alloc] initWithTodayIntegral:_signinModel.score];
        [view show];
        
        [YSAccountService fetchUserInfoWithCompletion:^(id result, id error) {
            _integralLabel.text = [NSString stringWithFormat:@"总积分: %zd", [YSAccount sharedAccount].score];
        }];
    }];
    
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
