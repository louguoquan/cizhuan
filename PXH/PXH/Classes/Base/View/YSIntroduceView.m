////
////  YSIntroduceView.m
////  PXH
////
////  Created by yu on 2017/8/28.
////  Copyright © 2017年 yu. All rights reserved.
////
//
//#import "YSIntroduceView.h"
//
//@interface YSIntroduceView () <UIScrollViewDelegate>
//
//@property (nonatomic, strong) UIPageControl *pageControl;
//
//@property (nonatomic, assign) BOOL isAnimating;
//
//@end
//
//static YSIntroduceView *_introduceView = nil;
//
//@implementation YSIntroduceView
//
//+ (instancetype)sharedInstance {
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _introduceView = [YSIntroduceView new];
//        [[UIApplication sharedApplication].keyWindow addSubview:_introduceView];
//        [_introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo([UIApplication sharedApplication].keyWindow);
//        }];
//    });
//    return _introduceView;
//}
//
//+ (void)show {
//    
//    [[self sharedInstance] initSubviews];
//}
//
//- (void)initSubviews {
//    
//    UIScrollView *scrollView = [UIScrollView new];
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.pagingEnabled = YES;
//    scrollView.delegate = self;
//    scrollView.bounces = NO;
//    [_introduceView addSubview:scrollView];
//    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_introduceView);
//    }];
//    
//    UIView *containerView = [UIView new];
//    [scrollView addSubview:containerView];
//    
//    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scrollView);
//        make.height.equalTo(scrollView);
//    }];
//    
//    UIImageView *lastView = nil;
//    for (int i = 0; i < 3; i ++) {
//        UIImageView *imageView = [UIImageView new];
//        SDLog(@"%.0f-%.0f-%zd", kScreenWidth*kScreenScale, kScreenHeight*kScreenScale, i+1);
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%.0f-%.0f-%zd", kScreenWidth*kScreenScale, kScreenHeight*kScreenScale, i+1]];
//        if (!image) {
//            image = [UIImage imageNamed:[NSString stringWithFormat:@"1242-2208-%zd", i+1]];
//        }
//        imageView.image = image;
//        [containerView addSubview:imageView];
//        
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (!lastView) {
//                make.left.offset(0);
//            } else {
//                make.left.equalTo(lastView.mas_right);
//            }
//            make.top.bottom.offset(0);
//            make.width.mas_equalTo(kScreenWidth);
//        }];
//        lastView = imageView;
//    }
//    
//    lastView.userInteractionEnabled = YES;
//    
//    SDButton *enterButton = [SDButton new];
//    enterButton.layer.cornerRadius = 2;
//    enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    enterButton.layer.borderWidth = 1.5;
//    enterButton.layer.masksToBounds = YES;
//    [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
//    enterButton.titleLabel.font = UIFontBoldMake(16);
//    [enterButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [lastView addSubview:enterButton];
//    
//    enterButton.hidden = YES;
//    
//    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(lastView);
//        make.bottom.offset(PreferredVarForDevices(-60, -80, -55, -35));
//        make.width.mas_equalTo(130);
//        make.height.mas_equalTo(40);
//    }];
//    
//    _pageControl = [UIPageControl new];
//    _pageControl.numberOfPages = 3;
//    _pageControl.currentPage = 0;
//    [_introduceView addSubview:_pageControl];
//    
//    _pageControl.hidden = YES;
//    
//    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_introduceView);
//        make.bottom.offset(PreferredVarForDevices(-35, -35, -35, -20));
//        make.height.mas_equalTo(8);
//    }];
//    
//    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(lastView).offset(kScreenWidth);
//    }];
//}
//
//- (void)dismiss {
//    
//    _isAnimating = YES;
//    [UIView animateWithDuration:1.0
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         _introduceView.alpha = 0;
//                     } completion:^(BOOL finished) {
//                         NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//                         [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:kApplicationLastVersion];
//                         [[NSUserDefaults standardUserDefaults] synchronize];
//                         
//                         [_introduceView removeFromSuperview];
//                         _isAnimating = NO;
//                     }];
//}
//
//#pragma mark - delegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat offsetX = scrollView.contentOffset.x;
//    if (offsetX > kScreenWidth*2 + 40) {
//        if (_isAnimating) {
//            return;
//        }
//        [self dismiss];
//    }
//    if (offsetX <= 0) {
//        scrollView.bounces = NO;
//    } else {
//        scrollView.bounces = YES;
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    CGFloat offsetX = scrollView.contentOffset.x;
//    NSInteger page = offsetX / kScreenWidth;
//    
//    _pageControl.currentPage = page;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
