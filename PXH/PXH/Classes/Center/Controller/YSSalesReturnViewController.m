//
//  YSSalesReturnViewController.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSalesReturnViewController.h"

#import "YSEditImagesView.h"

#import "YSOrderService.h"

@interface YSSalesReturnViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *priceTf;

@property (nonatomic, strong) UITextView    *reasonTv;

@property (nonatomic, strong) UITextField   *mobileTf;

@property (nonatomic, strong) YSEditImagesView  *imagesView;

@end

@implementation YSSalesReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"退货";
    
    [self setup];
}

- (void)setup {
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = MAIN_COLOR;
    [submitButton setTitle:@"提交申请" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *label = [self createLabelWithText:@"退款金额(元)"];
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(10);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view];
    {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = HEX_COLOR(@"#666666");
        label.textAlignment = NSTextAlignmentRight;
        label.text = [NSString stringWithFormat:@"最多可退%.2f元", _order.amountFee];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.offset(-10);
        }];
        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        _priceTf = [UITextField new];
        _priceTf.font = [UIFont systemFontOfSize:18];
        _priceTf.textColor = HEX_COLOR(@"#333333");
        _priceTf.delegate = self;
        [view addSubview:_priceTf];
        [_priceTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.offset(10);
            make.right.equalTo(label.mas_left).offset(-10);
        }];
    }
    
    UILabel *label1 = [self createLabelWithText:@"退货原因:"];
    [self.containerView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(20);
        make.left.offset(10);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view1];
    {
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(70);
        }];
        
        _reasonTv = [UITextView new];
        [view1 addSubview:_reasonTv];
        [_reasonTv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(10);
            make.right.bottom.offset(-10);
        }];
        
    }
    
    UILabel *label2 = [self createLabelWithText:@"联系电话:"];
    [self.containerView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(20);
        make.left.offset(10);
    }];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view2];
    {
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(44);
        }];
        
        _mobileTf = [UITextField new];
        _mobileTf.font = [UIFont systemFontOfSize:15];
        _mobileTf.textColor = HEX_COLOR(@"#999999");
        _mobileTf.placeholder = @"请输入联系方式";
        [view2 addSubview:_mobileTf];
        [_mobileTf mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(view2);
            make.left.offset(10);
            make.top.offset(0);
        }];
    }
    
    UILabel *label3 = [self createLabelWithText:@"上传凭证(最多5张):"];
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).offset(20);
        make.left.offset(10);
    }];
    
    _imagesView = [[YSEditImagesView alloc] initWithColumn:4 maxCount:9 addButtonImage:[UIImage imageNamed:@"comment_image_add"]];
    [self.containerView addSubview:_imagesView];
    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
    
}

- (void)confirm {
    if (_priceTf.text.length <= 0 || _priceTf.text.floatValue <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入退款金额" toContainer:nil];
        return;
    }
    
    if (_reasonTv.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入退款原因" toContainer:nil];
        return;
    }
    
    if (_mobileTf.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入联系方式" toContainer:nil];
        return;
    }
    
    if (_imagesView.images.count > 0) {
        [self uploadImages];
    }
    [self submit:nil];
}

- (void)uploadImages {
    
    [MBProgressHUD showLoadingText:@"上传图片中" toContainer:nil];
    [[SDDispatchingCenter sharedCenter] POST:kUploadImage_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < _imagesView.images.count; i ++) {
            NSData *data = UIImageJPEGRepresentation(_imagesView.images[i], 0.1);
            NSString *filename = [NSString stringWithFormat:@"%zd.jpg",i];
            [formData appendPartWithFileData:data name:@"images" fileName:filename mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *imageUrls = [result valueForKey:@"saveUrl"];
        [self submit:[imageUrls componentsJoinedByString:@","]];
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

- (void)submit:(NSString *)images {
    
    [MBProgressHUD showLoadingText:@"正在提交" toContainer:nil];
    if (![YSAccountService isMobile:_mobileTf.text]) {
        [MBProgressHUD showInfoMessage:@"请输入正确的手机号" toContainer:nil];
        return;
    }
    [YSOrderService refundsApply:_order.orderId
                            type:2
                          reason:_reasonTv.text
                          mobile:_mobileTf.text
                            desc:nil
                          amount:_priceTf.text
                          images:images
                      completion:^(id result, id error) {
                              [MBProgressHUD showSuccessMessage:@"提交成功" toContainer:nil];
                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                  [self.navigationController popViewControllerAnimated:YES];
                              });
                          }];

}

#pragma mark - textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([SDUtil textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (text.floatValue <= _order.amountFee) {
            return YES;
        }
    }
    return NO;
}

- (UILabel *)createLabelWithText:(NSString *)Text {
    UILabel *label = [UILabel new];
    label.text = Text;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEX_COLOR(@"#666666");
    return label;
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
