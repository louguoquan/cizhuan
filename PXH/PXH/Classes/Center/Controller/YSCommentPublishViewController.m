
//
//  YSProductCommentViewController.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCommentPublishViewController.h"

#import "YSCommentEditCell.h"

#import "YSOrderService.h"

@interface YSCommentPublishViewController ()

@end

@implementation YSCommentPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提交";
    
    [self setup];
}

- (void)setup {
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[YSCommentEditCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-55);
    }];
    
    WS(weakSelf);
    
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@55);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton jm_setCornerRadius:3 withBackgroundColor:MAIN_COLOR];
    [confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerView);
        make.left.offset(20);
        make.height.equalTo(@44);
    }];
}

- (void)confirm {
    [self.view endEditing:YES];
    
    //检查评论内容是否为空
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.extContent.length <= 0 || SELF.extContent == nil"];
    NSArray *result = [_order.items filteredArrayUsingPredicate:predicate];
    
    if ([result count] > 0) {
        [MBProgressHUD showInfoMessage:@"请输入评论内容" toContainer:nil];
        return;
    }
    
    NSPredicate *predicate2 = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        YSOrderProduct *product = evaluatedObject;
        if (product.extImages.count > 0) {
            return YES;
        }
        return NO;
    }];
    NSArray *result2 = [_order.items filteredArrayUsingPredicate:predicate2];
    
    if (result2.count > 0) {
        [self uploadImages:result2];
    }else {
        [self submitComment];
    }

}

- (void)uploadImages:(NSArray *)items
{
//    width": 750,
//    "savePath": "http://ol-quan2017.oss-cn-shanghai.aliyuncs.com/imgs/bbaccfc52363c2d4adb26eb8cae225c767a3530a",
//    "viewPath": "http://ol-quan2017.oss-cn-shanghai.aliyuncs.com/imgs/bbaccfc52363c2d4adb26eb8cae225c767a3530a",
//    "height": 468
    WS(weakSelf);
    [MBProgressHUD showLoadingText:@"上传图片中" toContainer:nil];
    [[SDDispatchingCenter sharedCenter] POST:kUploadImage_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < [items count]; i ++) {
            YSOrderProduct *product = items[i];
            for (UIImage *image in product.extImages) {
                NSData *data = UIImageJPEGRepresentation(image, 0.1);
                NSString *filename = [NSString stringWithFormat:@"%zd.jpg",i];
                [formData appendPartWithFileData:data name:@"images" fileName:filename mimeType:@"image/jpeg"];
            }
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [items setValue:[NSMutableArray array] forKey:@"extImageUrls"];
        NSArray *result = responseObject[@"result"];
        for (NSDictionary *imageMapper in result) {
            NSString *name = imageMapper[@"name"];
            NSRange range = [name rangeOfString:@".jpg"];
            if (range.location != NSNotFound) {
                NSMutableString *string = [NSMutableString stringWithString:name];
                [string deleteCharactersInRange:range];
                
                YSOrderProduct *product = items[string.integerValue];
                NSString *viewUrl = imageMapper[@"saveUrl"];
                NSMutableArray *array = [NSMutableArray arrayWithArray:product.extImageUrls];
                [array addObject:viewUrl];
                product.extImageUrls = array;
            }
        }
        [weakSelf submitComment];
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

- (void)submitComment
{
    NSMutableArray *jsonData = [NSMutableArray array];
    for (YSOrderProduct *product in _order.items) {
        NSMutableDictionary *commentJson = [NSMutableDictionary dictionary];
        commentJson[@"productId"] = product.productId;
        commentJson[@"serviceScores"] = @(product.extScore1);
        commentJson[@"expressScores"] = @(product.extScore2);
        commentJson[@"desc"] = product.extContent;
        commentJson[@"images"] = [product.extImageUrls componentsJoinedByString:@","];
        [jsonData addObject:commentJson];
    }
    
    NSString *jsonString = [jsonData mj_JSONString];
    [MBProgressHUD showLoadingText:@"正在提交评论" toContainer:nil];
    [YSOrderService orderComment:_order.orderId json:jsonString completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"评价成功" toContainer:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}


#pragma mark - Router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        YSOrderProduct *product = userInfo[@"model"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[self.order.items indexOfObject:product]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_order.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCommentEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.product = _order.items[indexPath.section];
    return cell;
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
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
