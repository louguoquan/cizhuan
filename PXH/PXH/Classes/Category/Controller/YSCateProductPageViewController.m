//
//  YSCateProductPageViewController.m
//  PXH
//
//  Created by yu on 2017/8/2.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateProductPageViewController.h"
#import "YSCateProductViewController.h"
#import "YSCategory.h"
#import "YSShoppingCartViewController.h"
#import "YSProductService.h"

@interface YSCateProductPageViewController()
{
    UIButton *selectButton;
}
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL pirceState;
@property (nonatomic, assign) BOOL brandsState;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation YSCateProductPageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"选择品牌" object:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.btnArray = [NSMutableArray array];
    self.selectIndex = 0;
    self.pirceState = YES;
    self.brandsState = YES;
    [self renderUI];
    [self creatSegmentView];
    [self setSelectedIndex:self.pageIndex animated:YES];
    [self setNav];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeFromView:) name:@"选择品牌" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(brandsChange) name:@"品牌切换" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeProductNum1) name:@"购物车改变数量" object:nil];
}

- (void)setNav{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(gotoShopCar) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 20, 20)];
    _countLabel.text = @"0";
    _countLabel.font = [UIFont systemFontOfSize:10];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.layer.cornerRadius = 10;
    _countLabel.layer.masksToBounds = YES;
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.backgroundColor = [UIColor redColor];
    [btn addSubview:_countLabel];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;
    
    [self changeProductNum1];
    
    
    
    
}

- (void)changeProductNum1
{
    [YSProductService fetchCartProductNum:^(id result, id error) {
        
        NSString *num = [result description];
        if (num.integerValue != 0) {
//            self.tabBarItem.badgeValue = num;
            _countLabel.text = num;
            _countLabel.hidden = NO;
        } else {
//            self.tabBarItem.badgeValue = nil;
            _countLabel.text = @"0";
            _countLabel.hidden = YES;
        }
    }];
}


- (void)gotoShopCar{
    
    YSShoppingCartViewController *vc = [[YSShoppingCartViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark - delegate

- (YSSegmentStyle *)segmentStyleForPageViewController {
    YSSegmentStyle *style = [YSSegmentStyle new];
    
    style.itemMargin = 30;
    style.canScrollTitle = YES;
    
    return style;
}

- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    return [YSCateProductViewController class];
}

- (NSArray *)titlesForPageViewController {
    
    return [_dataSource valueForKey:@"name"];
}

- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index {
    
    YSCategory *category = _dataSource[index];
    NSString *sort = [NSString stringWithFormat:@"%ld", 1];
    return @{@"cateId" : category.ID, @"sort" : sort};
}


#pragma mark - 筛选页面
- (void)creatSegmentView
{
    WS(weakSelf);
    UIView *secondSegmentView = [UIView new];
    [self.view addSubview:secondSegmentView];
    [secondSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(45);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    CGFloat itemWidth = kScreenWidth / 4.0;
    NSArray *array = @[@"综合排序", @"销量",@"价格", @"品牌"];
    for (NSInteger i = 0; i < array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        if (button.tag == self.selectIndex) {
            [button setTitleColor:MAIN_COLOR forState:0];
            selectButton = button;
        } else {
            [button setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
        }
        if (ScreenWidth == 320) {
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        } else {
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        
        if (i == 3) {
            [button setImage:[UIImage imageNamed:@"pull-down"] forState:0];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, itemWidth / 2 - 20)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(3, itemWidth / 2 + 20, 0, 0)];
        }
        [secondSegmentView addSubview:button];
        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            UIButton *selectSender = (UIButton *)sender;
            if (selectButton) {
                [selectButton setTitleColor:HEX_COLOR(@"#333333") forState:0];
            }
            selectButton = selectSender;
            
            weakSelf.selectIndex = selectSender.tag;
            [selectSender setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset(i * itemWidth + (itemWidth - 60) / 2.0);
            }];
            
            if (selectSender.tag == 0 || selectSender.tag == 1) {
                self.brandsState = YES;
                self.selectIndex = selectSender.tag + 1;
            }
            if (selectSender.tag == 2) {
                self.brandsState = YES;
                if (self.pirceState == YES) {
                    self.selectIndex = 3;
                    self.pirceState = NO;
                } else {
                    self.selectIndex = 4;
                    self.pirceState = YES;
                }
            }
            if (selectSender.tag == 3) {
                if (self.brandsState == YES) {
                    self.selectIndex = 5;
                    self.brandsState = NO;
                } else {
                    self.selectIndex = 6;
                    self.brandsState = YES;
                }
                
            }
            NSString *sort = [NSString stringWithFormat:@"%ld", self.selectIndex];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"分类筛选" object:sort];
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(itemWidth * i);
            make.width.mas_equalTo(itemWidth);
            make.top.bottom.offset(-1);
        }];
        [self.btnArray addObject:button];
    }
    
    UIView *grayView = [UIView new];
    grayView.backgroundColor = LINE_COLOR;
    [secondSegmentView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(44);
        make.left.right.offset(0);
        make.bottom.offset(0);
        
    }];
        
    _sliderView = [UIView new];
    _sliderView.backgroundColor = MAIN_COLOR;
    [secondSegmentView addSubview:_sliderView];
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((itemWidth - 60) / 2.0);
        make.bottom.offset(0);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(60);
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(secondSegmentView.mas_bottom);
    }];
}

- (void)removeFromView:(NSNotification *)noti
{
    NSString *buttonTitle = noti.object;
    UIButton *button = [self.btnArray lastObject];
    [button setTitle:buttonTitle forState:0];
    self.brandsState = YES;
    self.selectIndex = 6;
}

- (void)brandsChange
{
    UIButton *button = [self.btnArray lastObject];
    [button setTitle:@"品牌" forState:0];
    self.brandsState = YES;
    self.selectIndex = 6;
//    [selectButton setTitleColor:HEX_COLOR(@"#333333") forState:0];
//    UIButton *firstButton = self.btnArray[self.selectIndex];
//    selectButton = firstButton;
//    [firstButton setTitleColor:MAIN_COLOR forState:0];
//    CGFloat itemWidth = kScreenWidth / 4.0;
//    [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.offset((itemWidth - 60) / 2.0);
//    }];
}

@end
