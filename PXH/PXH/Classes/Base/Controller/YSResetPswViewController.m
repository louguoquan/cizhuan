////
////  YSResetPswViewController.m
////  PXH
////
////  Created by yu on 2017/8/14.
////  Copyright © 2017年 yu. All rights reserved.
////
//
//#import "YSResetPswViewController.h"
//
//#import "YSValidateButton.h"
//
//@interface YSResetPswViewController ()
//
//@property (nonatomic, strong) YSCellView    *mobileCell;
//
//@property (nonatomic, strong) YSCellView    *codeCell;
//
//@property (nonatomic, strong) YSCellView    *pswCell;
//
//@end
//
//@implementation YSResetPswViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.navigationItem.title = @"重置密码";
//    
//    [self initSubviews];
//}
//
//- (void)initSubviews {
//    
//    self.scrollView.backgroundColor = BACKGROUND_COLOR;
//    
//    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
//    _mobileCell.ys_title = @"手机号";
//    _mobileCell.ys_titleFont = [UIFont systemFontOfSize:14];
//    _mobileCell.ys_titleColor = HEX_COLOR(@"#666666");
//    _mobileCell.ys_titleWidth = 15 * 3;
//    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:14];
//    _mobileCell.ys_contentPlaceHolder = @"请输入手机号";
////    _mobileCell
//    [self.containerView addSubview:_mobileCell];
//    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(10);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(47);
//    }];
//    
//    _codeCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
//    _codeCell.ys_title = @"验证码";
//    _codeCell.ys_titleFont = [UIFont systemFontOfSize:14];
//    _codeCell.ys_titleColor = HEX_COLOR(@"#666666");
//    _codeCell.ys_titleWidth = 15 * 3;
//    _codeCell.ys_contentFont = [UIFont systemFontOfSize:14];
//    _codeCell.ys_contentPlaceHolder = @"请输入验证码";
//    [self.containerView addSubview:_codeCell];
//    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_mobileCell.mas_bottom).offset(1);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(47);
//    }];
//    
//    YSValidateButton *validateButton = [[YSValidateButton alloc] initWithSeconds:60];
//    validateButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    [validateButton setTitleColor:HEX_COLOR(@"#ff2f66") forState:UIControlStateNormal];
//    [validateButton setBackgroundImage:[UIImage imageNamed:@"codeBtn_Bg"] forState:UIControlStateNormal];
//    [validateButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        [sender sendCodeToPhoneNumber:_codeCell.ys_text type:3];
//    }];
//    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(25);
//        make.width.mas_equalTo(60);
//    }];
//    _mobileCell.ys_accessoryView = validateButton;
//    _mobileCell.ys_accessoryRightInsets = 10;
//    
//    _pswCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
//    _pswCell.ys_title = @"密码";
//    _pswCell.ys_titleFont = [UIFont systemFontOfSize:14];
//    _pswCell.ys_titleColor = HEX_COLOR(@"#666666");
//    _pswCell.ys_titleWidth = 15 * 3;
//    _pswCell.ys_contentFont = [UIFont systemFontOfSize:14];
//    _pswCell.ys_textFiled.secureTextEntry = YES;
//    _pswCell.ys_contentPlaceHolder = @"请输入手机号";
//    [self.containerView addSubview:_pswCell];
//    [_pswCell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_mobileCell.mas_bottom).offset(1);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(47);
//    }];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
//    [button setTitle:@"保存" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:18];
//    [self.containerView addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_pswCell.mas_bottom).offset(30);
//        make.left.offset(15);
//        make.right.offset(-15);
//        make.height.mas_equalTo(45);
//        make.bottom.offset(-20);
//    }];
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
