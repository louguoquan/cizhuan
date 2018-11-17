//
//  JJCommentViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/16.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCommentViewController.h"
#import "JJFillMessageTableViewController.h"
#import "JJFillCommentsTableViewController.h"

@interface JJCommentViewController()
@property (nonatomic,readwrite,strong) JJFillMessageTableViewController *fillMesVC;
@property (nonatomic,readwrite,strong) JJFillCommentsTableViewController *fillComVC;
@end
@implementation JJCommentViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpNav];
    [self setupUI];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"发口碑";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}
- (void)setupUI{
    UIView *buttonSelView = [UIView new];
    buttonSelView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:buttonSelView];
    
    UIButton *fillMesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fillMesBtn setTitle:@"01  填写瓷砖信息" forState:UIControlStateNormal];
    [fillMesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [fillMesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fillMesBtn.selected = YES;
    [self.view addSubview:fillMesBtn];
    
    UIButton *fillComBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fillComBtn setTitle:@"02  填写使用时间" forState:UIControlStateNormal];
    [fillComBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [fillComBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:fillComBtn];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize   = CGSizeMake(self.view.width * 2, 0);
    [self.view addSubview:scrollView];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:view];
    
    _fillMesVC = [JJFillMessageTableViewController new];
    [view addSubview:_fillMesVC.view];
    
    _fillComVC = [JJFillCommentsTableViewController new];
    [view addSubview:_fillComVC.view];
    
    [buttonSelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(0);
        make.left.equalTo(self.view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width/2);
        make.height.mas_equalTo(50);
    }];
    [fillMesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(0);
        make.left.equalTo(self.view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width/2);
        make.height.mas_equalTo(50);
    }];
    [fillComBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_equalTo(0);
        make.right.equalTo(self.view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width/2);
        make.height.mas_equalTo(50);
    }];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fillComBtn.mas_bottom).mas_equalTo(0);
        make.left.right.bottom.equalTo(self.view).mas_equalTo(0);
        
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    [_fillMesVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width);
    }];
    [_fillComVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fillMesVC.view.mas_right).mas_equalTo(0);
        make.top.bottom.equalTo(view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fillComVC.view.mas_right);
    }];
    __block typeof(self) weak_self = self;
    _fillMesVC.selNextBlock = ^{
        [scrollView setContentOffset:CGPointMake(weak_self.view.width, 0) animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            buttonSelView.origin = CGPointMake(weak_self.view.width/2, 0);
        }];
        fillComBtn.selected = YES;
        fillMesBtn.selected = NO;
    };
}
@end
