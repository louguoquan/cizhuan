//
//  JYAccountAuthController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAccountAuthController.h"
#import "YSChangePasswordViewController.h"

#import "YSProfileTableViewCell.h"
#import "JYPasswordController.h"
#import "JYBindGoogleAuthController.h"
#import "JYPresentAddManagerController.h"
#import "JYGatherAddManagerController.h"

#import "JYRealNameAuthController.h"
#import "JYVerifFundsPwsController.h"
#import "JYBindingController.h"

#import "JYMineService.h"

@interface JYAccountAuthController (){
    
    NSArray  *_titleArr;
    NSArray *_detailArr;
}

@end

@implementation JYAccountAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setupTableView];
    
    [self getUserInfoStatus];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"账号认证";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{
    self.tableView.estimatedRowHeight = 51.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self setUpBase];
}

- (void)setUpBase
{
    JYAccountModel *account = [JYAccountModel sharedAccount];
    
    //是否已绑定
    BOOL isMobile = account.isMobile.boolValue;
    NSString *phoneStr = isMobile?@"换绑手机":@"绑定手机";
    NSString *phoneDetailStr = isMobile?account.mobile:@"去绑定";
    
    BOOL isEmail = account.isEmail.boolValue;
    NSString *emailStr = isEmail?@"换绑邮箱":@"绑定邮箱";
    NSString *emailDetailStr = isEmail?account.email:@"去绑定";
    
    NSInteger isCertified = account.isCertified.integerValue;
    NSString *certifiedDetailStr = @"未认证";//0
    switch (isCertified) {
        case 1: certifiedDetailStr = @"审核中"; break;
        case 2: certifiedDetailStr = @"已认证"; break;
        case 3: certifiedDetailStr = @"已拒绝"; break;
    }
    
    BOOL isPayPassword = account.isPayPassword.boolValue;
    NSString *payDetailStr = isPayPassword?@"修改":@"去设置";
    
    _titleArr = @[phoneStr, emailStr, @"实名认证", @"登录密码", @"资金密码", @"谷歌验证", @"提币地址", @"收款地址"];
    _detailArr = @[phoneDetailStr, emailDetailStr, certifiedDetailStr, @"修改", payDetailStr];
}


- (void)getUserInfoStatus
{
    [JYMineService getUserInfoStatusCompletion:^(id result, id error) {
        [self setUpBase];
        [self.tableView reloadData];
    }];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13.f]];
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(CELLDETAILTEXT);
    
    
    if (indexPath.row>2 || indexPath.row==0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        cell.accessoryView = UIView.new;
    }
    
    if (indexPath.row < _titleArr.count-3) {
        NSString *detail = _detailArr[indexPath.row];
        
        //加星处理
        if (![detail isEqualToString:@"去绑定"]) {
            if (indexPath.row == 0) {
                detail = [self replaceStringWithAsterisk:detail startLocation:3 lenght:4];
            }
            else if (indexPath.row == 1) {
                NSString *replaceStr = [detail componentsSeparatedByString:@"@"].firstObject;
                detail = [self replaceStringWithAsterisk:detail startLocation:2 lenght:replaceStr.length-2];
            }
        }
        
        cell.detailTextLabel.text = detail;
    }
    
    cell.textLabel.text = _titleArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 2: {
            NSInteger isCertified = [JYAccountModel sharedAccount].isCertified.integerValue;
            if (isCertified==1 || isCertified==2) return;
            if ([self isMobileOrCertified:1]) return;
            
            JYRealNameAuthController *realNameVC = [[JYRealNameAuthController alloc] init];
            [self.navigationController pushViewController:realNameVC animated:YES];
            realNameVC.setUpSuccessBlock = ^{
                [self getUserInfoStatus];
            };
        }
            break;
        case 3: {
            if ([self isMobileOrCertified:1]) return;
            
            JYPasswordController *passwordVC = [[JYPasswordController alloc] init];
            passwordVC.pushType = PushType_LoginPsw;
            [self.navigationController pushViewController:passwordVC animated:YES];
        }
            break;
        case 4: {
            if ([self isMobileOrCertified:2]) return;
            
            JYPasswordController *passwordVC = [[JYPasswordController alloc] init];
            passwordVC.pushType = PushType_BankrollPws;
            [self.navigationController pushViewController:passwordVC animated:YES];
            passwordVC.setUpSuccessBlock = ^(PushType type) {
                [self getUserInfoStatus];
            };
        }
            break;
        case 5: {
            JYBindGoogleAuthController *bindVC = [[JYBindGoogleAuthController alloc] init];
            [self.navigationController pushViewController:bindVC animated:YES];
        }
            break;
        case 6: {
            JYPresentAddManagerController *addManagerVC = [[JYPresentAddManagerController alloc] init];
            [self.navigationController pushViewController:addManagerVC animated:YES];
        }
            break;
        case 7: {
            JYGatherAddManagerController *gatherManagerVC = [[JYGatherAddManagerController alloc] init];
            [self.navigationController pushViewController:gatherManagerVC animated:YES];
        }
            break;
        default: {
//            //是否已绑定
//            BOOL isBinding = [_titleArr[indexPath.row] containsString:@"换绑"];
//
//            if (isBinding) {//已绑定，验证资金密码,进行更换
//                JYVerifFundsPwsController *vc = [[JYVerifFundsPwsController alloc] init];
//                vc.pushType = indexPath.row;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            else{//未绑定,进行绑定

            JYBindingController *vc = [[JYBindingController alloc] init];
            vc.navTitle = _titleArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            vc.bindSuccessBlock = ^(NSInteger type, NSString *phoneOrEmail) {
                
                JYAccountModel *account = [JYAccountModel sharedAccount];
                if (type==1) {
                    account.mobile = phoneOrEmail;
                }else{
                    account.email = phoneOrEmail;
                }
                [JYAccountModel saveAccount:account];
                
                [self getUserInfoStatus];
            };
//            }
        }
            break;
    }
}


/**
 判断是否需要需要绑定手机或实名认证

 @param isBind  1.绑定手机; 2.实名认证
 */
- (BOOL)isMobileOrCertified:(NSInteger)isBind
{
    switch (isBind) {
        case 1: {
            NSString *isMobile = [JYAccountModel sharedAccount].isMobile;
            if (!isMobile || !isMobile.boolValue) {
                [MBProgressHUD showText:@"请绑定手机" toContainer:nil];
                return YES;
            }
        }
            break;
        case 2:{
            NSString *isCertified = [JYAccountModel sharedAccount].isCertified;
            if (!isCertified || isCertified.integerValue==0 || isCertified.integerValue==3) {
                [MBProgressHUD showText:@"请进行实名认证" toContainer:nil];
                return YES;
            }
        }
            break;
    }
    
    return NO;
}


#pragma mark - action

- (void)updateUserInfo:(NSDictionary *)parameters {
    [MBProgressHUD showLoadingText:@"正在修改" toContainer:nil];
    [YSAccountService updateUserInfo:parameters completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"修改成功" toContainer:nil];
        [self.tableView reloadData];
    }];
}


//MARK: -- 字符串星号处理
-(NSString *)replaceStringWithAsterisk:(NSString *)originalStr
                         startLocation:(NSInteger)startLocation
                                lenght:(NSInteger)lenght
{
    NSString *newStr = originalStr;
    
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        
        startLocation ++;
    }
    
    return newStr;
}


@end
