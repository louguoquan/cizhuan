//
//  JYMineController.m
//  PXH
//
//  Created by LX on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMineController.h"

#import "JYAccountAuthController.h"
#import "JYSystemSetupController.h"

#import "JYNoviceGuidanceController.h"
//#import "JYBulletinCenterController.h"
#import "JYAdvertiseListViewController.h"
#import "JYCustomerServiceController.h"
#import "JYContactUsController.h"
#import "JYReceiveBenefitsController.h"
#import "JYInvitationViewController.h"

#import "JYCurrencyBriefController.h"
#import "JYRateCriterionController.h"
#import "JYAboutUsController.h"

#import "JYLogInController.h"
#import "JYWebController.h"

#import "JYMineHeadView.h"
#import "JYPicturePicker.h"

#import "JJMineCell.h"


#import "JYImageModel.h"

#import "JYMineService.h"

//#import <Meiqia/MQChatViewManager.h>

#import "JJADListViewController.h"

#import "YSMemberInfoViewController.h"
#import "JJSafeSetViewController.h"

#import "YSWebViewController.h"






@interface JYMineController ()

@property (nonatomic, strong) JYMineHeadView    *headView;

@property (nonatomic, strong) UIButton          *exitBtn;

@property (nonatomic, strong) NSArray           *titleArr;
@property (nonatomic, strong) NSArray           *imgArr;


@property (nonatomic, strong) NSString           *helpUrl;

@property (nonatomic, strong) NSString           *emailStr;
@end

@implementation JYMineController

-(UIView *)headView
{
    WS(weakSelf)
    if (!_headView) {
        _headView = [[JYMineHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80.f)];
        _headView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        _headView.selLoginBlock = ^{
            [weakSelf pushLoginVC];
        };
        
        _headView.selHeadPhotoBlock = ^{
            [[JYPicturePicker sharedPicturePicker] pickUpCameraOrPhotoAlbum:weakSelf selImageBlock:^(UIImage *selImage) {
                weakSelf.headView.headImg = selImage;
                [JYMineService uploadImage:selImage completion:^(id result, id error) {
                    NSArray *arr = (NSArray *)result;
                    if (arr && arr.count>0) {
                        JYImageModel *imgModel = (JYImageModel *)arr.firstObject;
                        JYAccountModel *account = [JYAccountModel sharedAccount];
                        account.icon = imgModel.viewPath;
                    }
                }];
            }];
        };
    }
    return _headView;
}

- (UIButton *)exitBtn
{
    if (!_exitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, kScreenWidth, 51.f);
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [btn setTitle:@"退出登录" forState:0];
        [btn addTarget:self action:@selector(exitLogonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn dk_setBackgroundColorPicker:DKColorPickerWithKey(BUTTONBG)];
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(BUTTONTITLE) forState:0];
        
        _exitBtn = btn;
    }
    return _exitBtn;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    NSString *token = [JYAccountModel sharedAccount].token;
    if (token.length) {
        [JJMineService JJMobileMemberGetUserInfoCompletion:^(id result, id error) {
            
            [self.headView.headImgView sd_setImageWithURL:[NSURL URLWithString:[JYAccountModel sharedAccount].head] placeholderImage:[UIImage imageNamed:@"eth"]];
            
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage)];
//            self.headView.headImgView.userInteractionEnabled = YES;
//            [self.headView.headImgView addGestureRecognizer:tap];
            
            
            NSString *nickName = [JYAccountModel sharedAccount].username;
            self.headView.nameStr = nickName?nickName:@"昵称:";
        }];
        
        self.tableView.tableFooterView = self.exitBtn;
    }else{
        self.headView.nameStr = @"注册/登录";
        self.headView.numStr = @"";
        self.headView.headImg = [UIImage imageNamed:@"eth"];
        
        self.tableView.tableFooterView = nil;
    }
    
    [self query];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setNav];
    
    [self.view addSubview:self.headView];
    
    [self setUpTableView];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillAppear:) name:@"timeOutLogin" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconChange:) name:@"iconChange" object:nil];
}

- (void)iconChange:(NSNotification *)noti{
    
    
}


- (void)query{
    
    [JJMineService JJMobileMemberHelpCenterCompletion:^(id result, id error) {
        
        self.helpUrl = result[@"result"];
        
    }];
    
    [JJMineService JJMobileMemberOfficialEmailCompletion:^(id result, id error) {
        self.emailStr = result[@"result"];
        [self.tableView reloadData];
    }];
    
}

- (void)setNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"我的";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    //去掉导航栏底部线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 60, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    selectBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"设置" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    YSMemberInfoViewController *vc = [[YSMemberInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpTableView
{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    //避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    //解决tabBar遮挡
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //    self.tableView.bounces = NO;
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    
    [self.tableView registerClass:[JJMineCell class] forCellReuseIdentifier:@"JJMineCell"];
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}

- (void)setUpBase
{
    _titleArr = @[@[@"消息中心", @"联系客服", @"安全中心", @"帮助中心", @"关于我们"]
                  ];
    _imgArr = @[@[@"JJ_icon", @"JJ_Users", @"JJ_Rolodex", @"JJ_Help", @"JJ_Info"]
                ];
}

#pragma mark
#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJMineCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 1) {
          [cell setViewWithTitle:_titleArr[indexPath.section][indexPath.row] image:_imgArr[indexPath.section][indexPath.row] sub:self.emailStr];
    }else{
        [cell setViewWithTitle:_titleArr[indexPath.section][indexPath.row] image:_imgArr[indexPath.section][indexPath.row] sub:@""];
        
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {//新手指引
                [self pushVC:[JJADListViewController new]];
            }
            else if (indexPath.row == 1) {
                
                
                
//#pragma mark  最简单的集成方法: 全部使用meiqia的,  不做任何自定义UI.
//                MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
//                [chatViewManager setoutgoingDefaultAvatarImage:[UIImage imageNamed:@"meiqia-icon"]];
//                [chatViewManager pushMQChatViewControllerInViewController:self];
                
            }
            else if (indexPath.row == 2) {
                [self pushVC:[JJSafeSetViewController new]];
                
            }
            else if (indexPath.row == 3) {
                
                
                JYWebController *vc = [[JYWebController alloc]init];
                vc.urlString = self.helpUrl;
                vc.navTitle = @"帮助中心";
                [self.navigationController pushViewController:vc animated:YES];
                
                
                
            }
            else if (indexPath.row == 4) {
                
                [JJMineService requestMobileMemberAboutUsCompletion:^(id result, id error) {
                    JYWebController *vc = [[JYWebController alloc]init];
                    vc.urlString = result[@"result"];
                    vc.navTitle = @"关于我们";
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                
            }
        }
            break;
            
            
    }
}

- (void)pushVC:(UIViewController *)VC
{
    //    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)pushWevVC:(NSString *)urlStr withTitle:(NSString *)title
{
    JYWebController *vc = [[JYWebController alloc] init];
    vc.urlString = urlStr;
    vc.navTitle  = title;
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK: -- 退出登录
- (void)exitLogonAction:(UIButton *)sender
{
    NSLog(@"退出登录");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出当前账号?\n" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushLoginVC];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)pushLoginVC
{
    JYLogInController *loginVC = [[JYLogInController alloc] init];
    YSNavigationController *nav = [[YSNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        [JYAccountModel deleteAccount];
    }];
}


@end
