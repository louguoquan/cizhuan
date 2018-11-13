//
//  YSUserCenterViewController.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSUserCenterViewController.h"
#import "YSLifecircleService.h"
#import "YSLifeCircleModel.h"
@interface YSUserCenterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buy;
@property (weak, nonatomic) IBOutlet UIButton *recharge;

@end

@implementation YSUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buy.layer.borderColor = HEX_COLOR(@"#FF2D46").CGColor;
    self.buy.layer.cornerRadius = 3.f;
    
    self.recharge.layer.borderColor = [UIColor clearColor].CGColor;
    self.recharge.layer.cornerRadius = 3.f;
    
    self.navigationItem.title = @"会员中心";
    self.view.backgroundColor = [UIColor whiteColor];
        
    [self fetchLifeData];
    // Do any additional setup after loading the view from its nib.
}

- (void)creatUIWith:(YSLifeCircleModel *)model
{
    YSScrollView *scrollView = [YSScrollView new];
    CGFloat height;
    if (self.type == 0) {
        height = 0;
    } else {
        height = 64;
    }
    scrollView.frame = CGRectMake(0, height, self.view.frame.size.width, CGRectGetHeight([UIScreen mainScreen].bounds) - 202); //212
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UIView *toplineView = [UIView new];
    toplineView.backgroundColor = [UIColor grayColor];
    [scrollView addSubview:toplineView];
    [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) * 21 / 25);
    bgImageView.image = [UIImage imageNamed:@"bg"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [scrollView addSubview:bgImageView];
    [scrollView sendSubviewToBack:bgImageView];
    
    //头像
    UIImageView *logo = [UIImageView new];
    logo.contentMode = UIViewContentModeScaleAspectFill;
    logo.layer.cornerRadius = 30;
    logo.clipsToBounds = YES;
    [logo sd_setImageWithURL:[NSURL URLWithString:[YSAccount sharedAccount].logo] placeholderImage:kPlaceholderImage];
    [scrollView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(60);
        if([UIScreen mainScreen].bounds.size.width == 320) {
            make.left.top.offset(20);
        } else {
            make.top.equalTo(bgImageView.mas_top).offset(60);
            make.left.offset(20);
        }
     
    }];
    //昵称
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = HEX_COLOR(@"#FF2D46");
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = [YSAccount sharedAccount].nickName;
    [scrollView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logo.mas_top);
        make.left.equalTo(logo.mas_right).offset(10);
    }];
    
    //消费等级
    
    NSString *text;
    CGFloat levelWidth = 0;
    if ([YSAccount sharedAccount].isVip) {
        text = @"品行会员";
        levelWidth = [text boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width + 20;
        
    } else {
        text = [NSString stringWithFormat:@"已消费%.2f元，本月还需消费%.2f元成为会员", model.buyMoney, model.shortMoney];
    }
    
    UILabel *level = [UILabel new];
    
    level.font = [UIFont systemFontOfSize:15];
    level.backgroundColor = HEX_COLOR(@"#FF2D46");
    level.layer.masksToBounds = YES;
    level.layer.cornerRadius = 10;
    level.numberOfLines = 0;
    level.textAlignment = NSTextAlignmentCenter;
    level.textColor = [UIColor whiteColor];
    level.text = text;
    
    [scrollView addSubview:level];
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.left.equalTo(nameLabel);
        
        if ([YSAccount sharedAccount].isVip) {
            
            make.width.mas_equalTo(levelWidth);
            
        } else {
            make.right.equalTo(self.view).offset(-10);
        }
        
        make.height.mas_equalTo(40);
    }];

    
    
    UILabel *label = [UILabel new];
    label.backgroundColor = MAIN_COLOR;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 3;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"升级会员";
    label.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(level.mas_bottom).offset(20);
        make.left.offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *rulesLabel = [UILabel new];
    rulesLabel.numberOfLines = 0;
    rulesLabel.font = [UIFont systemFontOfSize:14];
    rulesLabel.textColor = MAIN_COLOR;
    rulesLabel.text = model.tips;
    [scrollView addSubview:rulesLabel];
    [rulesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5);
        make.left.equalTo(label.mas_left);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    UIView *segmentView1 = [self segmentViewForTitle:@"尊享特权"];
    [scrollView addSubview:segmentView1];
    [segmentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rulesLabel.mas_bottom).offset(18);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(220);
        make.centerX.equalTo(self.view);
    }];
    
    UIScrollView *permissionScrollView = [UIScrollView new];
//    permissionScrollView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:permissionScrollView];
    [permissionScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentView1.mas_bottom).offset(18);
        make.left.right.offset(0);
        make.height.mas_equalTo(130);
        make.width.mas_equalTo(self.view);
    }];
    
    [permissionScrollView removeAllSubviews];
    for (NSInteger i = 0; i < model.images.count; i ++) {
        UIImageView *imageView = [UIImageView new];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.images[i]] placeholderImage:kPlaceholderImage];
        [permissionScrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(permissionScrollView);
            make.left.offset(25 + (100 + 15) * i);
            make.width.mas_equalTo(100);
            if (i == (model.images.count - 1)) {
                make.right.offset(-25);
            }
        }];
    }
}

#pragma mark - 获取数据
- (void)fetchLifeData {
    
    [YSLifecircleService fetchLifeIndexData:^(id result, id error) {
        if (result) {
            [self creatUIWith:result];
        }
    }];
}


//充值
- (IBAction)recharge:(id)sender {
    
    Class aclass = NSClassFromString(@"YSRechargeViewController");
    UIViewController *vc = [[aclass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//购物
- (IBAction)shopping:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"会员中心购物" object:nil];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:NO];
}

- (UIView *)segmentViewForTitle:(NSString *)title {
    UIView *view = [UIView new];
    
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = HEX_COLOR(@"#333333");
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.mas_equalTo(80);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(view);
        make.right.equalTo(label.mas_left);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = LINE_COLOR;
    [view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(view);
        make.left.equalTo(label.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    return view;
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
