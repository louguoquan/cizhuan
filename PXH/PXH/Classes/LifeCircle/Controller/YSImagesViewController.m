//
//  YSImagesViewController.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSImagesViewController.h"

@interface YSImagesViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YSImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
        make.left.top.right.bottom.offset(0);
    }];
    [self creatImageView];
}

- (void)creatImageView
{
    NSArray *array = _dic[@"images"];
    NSInteger selectIndex = [_dic[@"select"] integerValue] - 10000;
    self.title = [NSString stringWithFormat:@"%ld/%ld", selectIndex + 1, array.count];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * array.count, CGRectGetHeight(self.view.frame) - 64);
    for (int i = 0; i < array.count; i++) {
        UIImageView *newImageView = [UIImageView new];
        newImageView.contentMode = UIViewContentModeScaleAspectFill;
        newImageView.clipsToBounds = YES;
        newImageView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
        [newImageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:kPlaceholderImage];
        [_scrollView addSubview:newImageView];
    }
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame) * selectIndex, 0) animated:YES];
}

- (void)setDic:(NSDictionary *)dic
{
    if (!_dic) {
        _dic = dic;
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前视图的宽度
    CGFloat pageWith = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((scrollView.contentOffset.x - pageWith / 2) / pageWith)+1;
    NSLog(@"当前页数:%d", page);
    NSArray *array = _dic[@"images"];
    self.title = [NSString stringWithFormat:@"%d/%ld", page + 1, array.count];
    
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
