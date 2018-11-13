//
//  YSIntegralRulesViewController.m
//  PXH
//
//  Created by yu on 2017/8/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSIntegralRulesViewController.h"
#import "YSAccountService.h"
#import "YSScoreRule.h"
@interface YSIntegralRulesViewController ()


@end

@implementation YSIntegralRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"积分规则";
    [self fetchScoreRule];
    // Do any additional setup after loading the view.
}

- (void)initSubViewWith:(YSScoreRule *)ruleModel
{
    WS(weakSelf);
    UIView *lineView = [UIView new];
    lineView.backgroundColor = HEX_COLOR(@"#666666");
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(1);
        make.width.equalTo(weakSelf.view);
    }];
    UILabel *rule = [self labelWith:@"积分具体规则" textColor:HEX_COLOR(@"#ef5454") font:18];
    [self.view addSubview:rule];
    [rule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.left.offset(18);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *detailRule = [self labelWith:ruleModel.role textColor:HEX_COLOR(@"#666666") font:14];
    detailRule.numberOfLines = 0;
    [self.view addSubview:detailRule];
    [detailRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rule.mas_bottom).offset(10);
        make.left.equalTo(rule);
        make.right.mas_equalTo(-18);
    }];
}

- (void)fetchScoreRule
{
    [MBProgressHUD showLoadingText:@"正在获取数据" toContainer:nil];
    [YSAccountService scoreRuleWithCompletion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        YSScoreRule *ruleModel = result;
        [self initSubViewWith:ruleModel];
    }];
}

- (UILabel *)labelWith:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
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
