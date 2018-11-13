//
//  YSCouponCommentViewController.m
//  PXH
//
//  Created by yu on 2017/8/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponCommentViewController.h"

#import <IQTextView.h>
#import "YSEditImagesView.h"
#import <HCSStarRatingView.h>

#import "YSLifecircleService.h"

@interface YSCouponCommentViewController ()

@property (nonatomic, strong) IQTextView    *contentTv;

@property (nonatomic, strong) YSEditImagesView      *imagesView;

@property (nonatomic, strong) HCSStarRatingView     *ratingView;

@end

@implementation YSCouponCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = _coupon.shopName;
    
    [self setup];
}

- (void)setup {
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-55);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(55);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:2 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.height.mas_equalTo(44);
        make.left.offset(15);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#666666");
    label.text = @"服务评分";
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(90);
    }];
    
    _ratingView = [[HCSStarRatingView alloc] init];
    _ratingView.maximumValue = 5;
    _ratingView.continuous = YES;
    _ratingView.emptyStarImage = [UIImage imageNamed:@"evaluate_star_grey"];
    _ratingView.filledStarImage = [UIImage imageNamed:@"evaluate_star"];
    [self.containerView addSubview:_ratingView];
    [_ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.left.equalTo(label.mas_right);
        make.centerY.equalTo(label);
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    _contentTv = [IQTextView new];
    _contentTv.font = [UIFont systemFontOfSize:13];
    _contentTv.textColor = HEX_COLOR(@"#333333");
    _contentTv.placeholder = @"说两句吧...";
    [self.containerView addSubview:_contentTv];
    [_contentTv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.height.equalTo(@60);
    }];
    
    _imagesView = [[YSEditImagesView alloc] initWithColumn:4 maxCount:9 addButtonImage:[UIImage imageNamed:@"comment_image_add"]];
    [self.containerView addSubview:_imagesView];
    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentTv.mas_bottom);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-20);
    }];
}

- (void)confirm {
    [self.view endEditing:YES];
    
    if (_contentTv.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入评论内容" toContainer:nil];
        return;
    }
    
    if (_imagesView.images.count > 0) {
        [self uploadImages];
    }else {
        [self submitComment:nil];
    }
    
}

- (void)uploadImages
{
    //    width": 750,
    //    "savePath": "http://ol-quan2017.oss-cn-shanghai.aliyuncs.com/imgs/bbaccfc52363c2d4adb26eb8cae225c767a3530a",
    //    "viewPath": "http://ol-quan2017.oss-cn-shanghai.aliyuncs.com/imgs/bbaccfc52363c2d4adb26eb8cae225c767a3530a",
    //    "height": 468
    WS(weakSelf);
    [MBProgressHUD showLoadingText:@"上传图片中" toContainer:nil];
    [[SDDispatchingCenter sharedCenter] POST:kUploadImage_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < [_imagesView.images count]; i ++) {
            NSData *data = UIImageJPEGRepresentation(_imagesView.images[i], 0.1);
            NSString *filename = [NSString stringWithFormat:@"%zd.jpg",i];
            [formData appendPartWithFileData:data name:@"images" fileName:filename mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *images = [result valueForKey:@"saveUrl"];
        [weakSelf submitComment:images];
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

- (void)submitComment:(NSArray *)images
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"images"] = [images componentsJoinedByString:@","];
    parameters[@"couponId"] = _coupon.ID;
    parameters[@"memberId"] = USER_ID;
    parameters[@"score"] = @(_ratingView.value);
    parameters[@"content"] = _contentTv.text;    
    [MBProgressHUD showLoadingText:@"正在提交评论" toContainer:nil];
    [YSLifecircleService couponComment:parameters completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"评价成功" toContainer:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
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
