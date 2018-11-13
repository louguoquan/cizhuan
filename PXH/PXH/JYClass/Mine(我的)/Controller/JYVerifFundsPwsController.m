//
//  JYVerifFundsPwsController.m
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYVerifFundsPwsController.h"
#import "JYBindingController.h"

@interface JYVerifFundsPwsController ()

@property (nonatomic, strong) YSCellView    *verifPwsCell;

@end

@implementation JYVerifFundsPwsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    navigationLabel.text = @"验证资金密码";
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentTextColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.secureTextEntry = YES;
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    cell.ys_titleWidth = 15*4;
    cell.ys_title = @"资金密码";
    cell.ys_contentPlaceHolder = @"请输入资金密码";
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    [self.containerView addSubview:cell];

    UIButton *visualBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [visualBtn setImage:[UIImage imageNamed:@"showPws"] forState:0];
    [visualBtn setImage:[UIImage imageNamed:@"hidePws"] forState:UIControlStateSelected];
    [visualBtn addTarget:self action:@selector(showAndHidePassword:) forControlEvents:UIControlEventTouchUpInside];
//    visualBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [visualBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30.f);
    }];
    cell.ys_accessoryView = visualBtn;
    cell.ys_accessoryRightInsets = 10.f;

    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10.f);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(51.f);
    }];
    
    _verifPwsCell = cell;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 2.f;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btn];
    btn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verifPwsCell.mas_bottom).offset(30);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-30.f);
    }];
}


//显示和隐藏视图的密码
-(void)showAndHidePassword:(UIButton *)sender
{
    //避免明文/密文切换后光标位置偏移
    _verifPwsCell.ys_textFiled.enabled = NO;
    _verifPwsCell.ys_textFiled.secureTextEntry = sender.selected;
    
    sender.selected = !sender.selected;
    
    _verifPwsCell.ys_textFiled.enabled = YES;
    [_verifPwsCell.ys_textFiled becomeFirstResponder];
}

- (void)nextAction:(UIButton *)sender
{
    NSLog(@"下一步");
    
    if (![self check_Number:_verifPwsCell.ys_textFiled.text]) {
        [MBProgressHUD showText:@"密码为6位数字" toContainer:nil];
        return;
    }
    
    //发送网络请求,验证资金密码,验证成功跳转
    
    NSString *navTitle = self.pushType?@"换绑邮箱":@"换绑手机";
    
    JYBindingController *vc = [[JYBindingController alloc] init];
    vc.navTitle = navTitle;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)setPushType:(PushVerifFundsType)pushType
{
    _pushType = pushType;
}

#pragma 正则匹配数字(6位)
- (BOOL)check_Number:(NSString *)string
{
    NSString *emailRegex = @"^\\d{6}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

@end
