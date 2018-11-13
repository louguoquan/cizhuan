//
//  YSMemberInfoViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMemberInfoViewController.h"
#import "YSChangePasswordViewController.h"

#import "YSProfileTableViewCell.h"

@interface YSMemberInfoViewController () {
    
    NSArray  *_dataSource;
}

@end

@implementation YSMemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"个人资料";
    [self setUpNav];
    
    [self setupTableView];
    
    [self query];
}

- (void)setupTableView {
    _dataSource = @[@[@"头像", @"昵称" ,@"用户手机号"]];
    
    [self.tableView registerClass:[YSProfileTableViewCell class] forCellReuseIdentifier:@"cell"];

   
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"设置";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)query{
    
    [JJMineService JJMobileMemberGetUserInfoCompletion:^(id result, id error) {
        
        [self.tableView reloadData];
    }];
    
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *array = _dataSource[indexPath.section];
    cell.titleLabel.text = array[indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        cell.descLabel.hidden = YES;
        cell.rightImageView.hidden = NO;
        
        [cell.rightImageView sd_setImageWithURL:[NSURL URLWithString:[JYAccountModel sharedAccount].head] placeholderImage:kPlaceholderImage];
    }else {
        cell.descLabel.hidden = NO;
        cell.rightImageView.hidden = YES;
    }
    
    cell.descLabel.textColor = HEX_COLOR(@"#666666");
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.descLabel.text = [JYAccountModel sharedAccount].username;
    }else if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            cell.descLabel.text = [JYAccountModel sharedAccount].mobile;
        }
//        else {
//            cell.descLabel.textColor = MAIN_COLOR;
//            cell.descLabel.text = @"修改";
//        }
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //修改头像
            [self chooseImage];
        }else  if (indexPath.row == 1){
            //修改昵称
            [[[MMAlertView alloc] initWithInputTitle:@"修改昵称" detail:nil placeholder:[YSAccount sharedAccount].nickName handler:^(NSString *text) {
                if (text.length > 0 && text.length < 9) {
                    [self updateUserInfo:@{@"userName":text}];
                } else {
                    [MBProgressHUD showInfoMessage:@"昵称不得超过8位" toContainer:nil];
                }
            }] show];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            YSChangePasswordViewController *vc = [YSChangePasswordViewController new];
            vc.type = indexPath.row + 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - action

//选择头像
- (void)chooseImage {
    
    WS(weakSelf);
    [YSImagePickerManager ys_ChooseImagesWithMaxCount:1 delegate:self complateBlock:^(NSArray *imageArray) {
        if (imageArray.count > 0) {
            [MBProgressHUD showLoadingText:@"正在上传头像" toContainer:self.view];
            [[SDDispatchingCenter sharedCenter] POST:kUploadImage_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:UIImageJPEGRepresentation([imageArray firstObject], 0.5) name:@"imgFile" fileName:@"image.jpg" mimeType:@"image/jpeg"];
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                [MBProgressHUD dismissForContainer:self.view];
                NSDictionary *result = responseObject[@"result"];
                NSDictionary *dict = result;
                [weakSelf updateUserInfo:@{@"touxiang":dict[@"savePath"]}];
            } failure:^(NSURLSessionDataTask *task, SDError *error) {
                [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
            }];
        }
    }];
}

- (void)updateUserInfo:(NSDictionary *)parameters {
    [MBProgressHUD showLoadingText:@"正在修改" toContainer:self.view];
    [YSAccountService updateUserInfo:parameters completion:^(id result, id error) {
        
        if (!error) {
            [MBProgressHUD showSuccessMessage:@"修改成功" toContainer:self.view];
            [self query];
            
        }else{
            SDError *error1 = error;
             [MBProgressHUD showErrorMessage:error1.errorMessage toContainer:self.view];
        }
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
