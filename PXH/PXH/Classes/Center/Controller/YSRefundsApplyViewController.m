//
//  YSRefundsApplyViewController.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRefundsApplyViewController.h"

#import "SDSelectView.h"

#import "YSOrderService.h"

@interface YSRefundsApplyViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *priceTf;

@property (nonatomic, strong) UITextView    *reasonTv;

@property (nonatomic, strong) UITextField   *mobileTf;

//@property (nonatomic, strong) YSCellView    *reasonCell;

@end

@implementation YSRefundsApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"退款";
    
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
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
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
            make.height.mas_equalTo(30);
        }];
    }
    
//    UILabel *label1 = [self createLabelWithText:@"货物状态:"];
//    [self.containerView addSubview:label1];
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_bottom).offset(20);
//        make.left.offset(10);
//    }];
//
//    _reasonCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
//    _reasonCell.ys_textFiled.userInteractionEnabled = NO;
//    _reasonCell.backgroundColor = [UIColor whiteColor];
//    _reasonCell.ys_accessoryType = YSCellAccessoryDropdown;
//    _reasonCell.ys_contentPlaceHolder = @"请选择货物状态";
//    _reasonCell.ys_contentFont = [UIFont systemFontOfSize:15];
//    [self.containerView addSubview:_reasonCell];
//    [_reasonCell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label1.mas_bottom).offset(10);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(44);
//    }];
//    WS(weakSelf);
//    NSArray *array = @[@"已收到货", @"未收到货"];
//    [_reasonCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        [[[SDSelectView alloc] initWithTitle:@"请选择货物状态" array:array handler:^(NSInteger index) {
//            weakSelf.reasonCell.ys_text = array[index];
//        }] show];
//    }];
    
    UILabel *label2 = [self createLabelWithText:@"退货原因:"];
    [self.containerView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(20);
        make.left.offset(10);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view1];
    {
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(10);
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

    UILabel *label3 = [self createLabelWithText:@"联系电话:"];
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(20);
        make.left.offset(10);
    }];

    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view2];
    {
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(44);
            make.bottom.offset(-10);
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
    
}

- (void)submit {
    if (_priceTf.text.length <= 0 || _priceTf.text.floatValue <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入退款金额" toContainer:nil];
        return;
    }
    
//    if (_reasonCell.ys_text.length <= 0) {
//        [MBProgressHUD showInfoMessage:@"请选择货物状态" toContainer:nil];
//        return;
//    }
    
    if (_reasonTv.text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入退款原因" toContainer:nil];
        return;
    }
    
//    if (_mobileTf.text.length <= 0) {
//        [MBProgressHUD showInfoMessage:@"请输入联系方式" toContainer:nil];
//        return;
//    }
    if (![YSAccountService isMobile:_mobileTf.text]) {
        [MBProgressHUD showInfoMessage:@"请输入正确的联系方式" toContainer:nil];
        return;
    }
    
    [MBProgressHUD showLoadingText:@"正在提交" toContainer:nil];
    [YSOrderService refundsApply:_order.orderId
                            type:1
                          reason:_reasonTv.text
                          mobile:_mobileTf.text
                            desc:nil
                          amount:_priceTf.text
                          images:nil completion:^(id result, id error) {
                              [MBProgressHUD showSuccessMessage:@"提交成功" toContainer:nil];
                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                  [self.navigationController popViewControllerAnimated:YES];
                                  [[NSNotificationCenter defaultCenter]postNotificationName:@"订单状态刷新" object:nil];

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
