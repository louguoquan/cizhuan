//
//  YSScrollPageViewController.m
//  HouseDoctorMember
//
//  Created by yu on 16/8/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSScrollPageViewController.h"

@interface YSScrollPageViewController ()<UIScrollViewDelegate>
{
    CGFloat     _oldOffSetX;
    
    NSInteger   _oldIndex;
}

@property (nonatomic, strong) NSMutableArray        *viewModels;

@property (nonatomic, strong) YSSegmentStyle        *segmentStyle;

//所有子视图
@property (nonatomic, strong) NSMutableDictionary   *viewControllerMapper;

@end

@implementation YSScrollPageViewController

- (NSMutableArray *)viewModels
{
    if (!_viewModels) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}

- (NSMutableDictionary *)viewControllerMapper
{
    if (!_viewControllerMapper) {
        _viewControllerMapper = [NSMutableDictionary dictionary];
    }
    return _viewControllerMapper;
}

- (YSSegmentView *)segmentView
{
    if (!_segmentView) {
        WS(weakSelf);
        _segmentView = [[YSSegmentView alloc] initWithFrame:CGRectZero
                                               segmentStyle:_segmentStyle
                                                 viewModels:_viewModels
                                       segmentUpdateHandler:^(YSSegmentItem *item) {
                                           [weakSelf adjustSegementItem:item];
                                       }
                                               clickHandler:^(YSSegmentItem *item) {
                                                   [weakSelf setSelectedIndex:item.tag animated:NO];
                                               }];
    }
    
    return _segmentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)renderUI
{
    [self initData];
    [self setupSegmentView];
    [self setupContentView];
}

- (void)initData
{
    _oldIndex = 0;
    _currentIndex = -1;
    _oldOffSetX = 0.0;
    
    [self getViewModels];
}

- (void)getViewModels
{
    //清空数据
    [self.viewModels removeAllObjects];

    NSArray *titleArray = [self titlesForPageViewController];
    NSArray *subTitleArray = [self subTitlesForPageViewController];
    NSArray *iconArray = [self iconImageForPageViewController];
    NSArray *selectIconArray = [self selectedIconImagePageViewController];
    
    for (NSInteger i = 0; i < [titleArray count]; i ++) {
        YSSegmentItemViewModel *viewModel = [YSSegmentItemViewModel new];
        viewModel.title = titleArray[i];
        viewModel.normalIcon = iconArray[i];
        viewModel.selectIcon = selectIconArray[i];
        viewModel.subTitle = subTitleArray[i];
        [self.viewModels addObject:viewModel];
    }
}

//创建 segmentView
- (void)setupSegmentView
{
    WS(weakSelf);
    
    self.segmentStyle = [self segmentStyleForPageViewController];
    
    [self.view addSubview:self.segmentView];
    
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.segmentStyle.itemHeight);
    }];
}

- (void)setupContentView
{
    WS(weakSelf);
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.segmentView.mas_bottom);
    }];
    
    [self.scrollView layoutIfNeeded];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.height.equalTo(weakSelf.scrollView);
        make.width.equalTo(@(weakSelf.scrollView.width * weakSelf.viewModels.count));
    }];
    
    //添加第一个视图
    [self setSelectedIndex:0 animated:NO];
}

#pragma mark - public helper

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (selectedIndex != self.segmentView.currentIndex) {
        [self.segmentView layoutIfNeeded];
        [self.segmentView setSelectedIndex:selectedIndex animated:animated];
    }
    
    if (self.currentIndex != selectedIndex) {
        [self.scrollView layoutIfNeeded];
        self.currentIndex = selectedIndex;
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * selectedIndex, 0) animated:animated];
        
        [self addViewControllerViewAtIndex:selectedIndex];
        [self contentViewEndMove];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"品牌切换" object:nil];
}

/**  给外界重新设置视图内容的标题的方法 */

- (void)reloadTitles
{
    [self getViewModels];

    //刷新标题
    [self.segmentView reloadTitlesWithNewViewModels:self.viewModels];
    
    [self.segmentView adjustUIWithProgress:1.0 oldIndex:_currentIndex currentIndex:_currentIndex];
}

- (void)reloadChildVcs
{
    WS(weakSelf);
    //清空数据
    [self.viewControllerMapper removeAllObjects];
    
    [self initData];
    
    //清空子视图
    [self.containerView removeAllSubviews];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    //刷新标题
    [self.segmentView reloadTitlesWithNewViewModels:self.viewModels];
    
    //重新设置contentScrollView
    [self.scrollView layoutIfNeeded];
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.height.equalTo(weakSelf.scrollView);
        make.width.equalTo(@(weakSelf.scrollView.width * weakSelf.viewModels.count));
    }];
    //添加第一个视图
    [self addViewControllerViewAtIndex:0];
    
    [self setSelectedIndex:0 animated:NO];
}

- (void)refresh
{
    WS(weakSelf);
    [self.viewControllerMapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        YSBaseViewController *vc = obj;
        [vc mj_setKeyValues:[weakSelf extensionForChildViewControllerAtIndex:[key integerValue]]];

        if ([vc respondsToSelector:@selector(refresh)]) {
            [vc performSelector:@selector(refresh)];
        }
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat containerWidth = self.scrollView.width;
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat temp = offSetX / containerWidth;
    CGFloat progress = temp - floor(temp);  //偏移进度/比例   0 - 1
    if (progress == 0.0) {  // 等于0 代表没有偏移
        return;
    }
    
    NSInteger fromIndex = 0;
    NSInteger toIndex = 0;
    
    if (offSetX - _oldOffSetX >= 0) {   //向右滑动
        _currentIndex = floor(temp);
        
        fromIndex = _currentIndex;
        toIndex = _currentIndex + 1;
        
    }else { //像左滑动
        _currentIndex = ceil(temp);
        
        fromIndex = _currentIndex;
        toIndex = _currentIndex - 1;
        
        progress = 1 - progress;
    }
    
    //移动SegmentView
    [self contentViewDidMoveFromIndex:fromIndex toIndex:toIndex progress:progress];
}

/**为了解决在滚动或接着点击title更换的时候因为index不同步而增加了下边的两个代理方法的判断*/

//scrollView 将要开始滑动  记录初始位置
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldOffSetX = scrollView.contentOffset.x;
}

/** 滚动减速完成时再更新title的位置 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = (scrollView.contentOffset.x / self.scrollView.width);
    [self contentViewEndMove];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        _currentIndex = (scrollView.contentOffset.x / self.scrollView.width);
        [self contentViewEndMove];
    }
}

#pragma mark - private helper
//滑动中调整  segmentView
- (void)contentViewDidMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress
{
    if(self.segmentView) {
        [self.segmentView adjustUIWithProgress:progress oldIndex:fromIndex currentIndex:toIndex];
    }
    [self addViewControllerViewAtIndex:toIndex];
}

//已经结束滑动
- (void)contentViewEndMove
{
    if(self.segmentView) {
        [self.segmentView adjustUIWithProgress:1.0 oldIndex:_currentIndex currentIndex:_currentIndex];
    }
    
    for (NSNumber *key in self.viewControllerMapper) {
        if (key.integerValue != _currentIndex) {
            [self removeViewControllerAtIndex:key.integerValue];
        }
    }
}

//添加视图
- (void)addViewControllerViewAtIndex:(NSInteger)index
{
    YSBaseViewController *vc = [self.viewControllerMapper objectForKey:@(index)];
    if (vc) {   //创建过  从缓存中拿出来加入视图
        if (vc.parentViewController) {  //已经显示  不做处理
            return;
        }
    }else {     //没有创建过  创建新的加入视图
        Class vclass = [self childViewControllersForPageViewControllerAtIndex:index];
        vc = [[vclass alloc] init];
    }
    
    [self moveViewControllerToParentViewController:vc index:index];

}

    //将视图添加到屏幕上
- (void)moveViewControllerToParentViewController:(YSBaseViewController *)viewController index:(NSInteger)index
{
    viewController.pageIndex = index;
    [viewController mj_setKeyValues:[self extensionForChildViewControllerAtIndex:index]];
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    [self.containerView addSubview:viewController.view];
    
    [self.viewControllerMapper setObject:viewController forKey:@(index)];
    
    WS(weakSelf);
    [viewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(index * weakSelf.scrollView.width));
        make.top.bottom.equalTo(weakSelf.containerView);
        make.width.equalTo(weakSelf.scrollView);
    }];
}

//移除不显示的视图
- (void)removeViewControllerAtIndex:(NSInteger)index
{
    UIViewController *vc = [self.viewControllerMapper objectForKey:@(index)];
    if (vc) {
        [vc.view removeFromSuperview];
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}


/**********************************代理实现.子类需自定义**********************************/
#pragma mark - delete

/*获取所有标签标题*/
- (NSArray *)titlesForPageViewController
{
    return @[@"视图1",@"视图2",@"视图3",@"视图4"];
}

/*获取Index对应位置的视图类名(字符串或Class) */
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index
{
    return [YSBaseViewController class];
}

- (NSArray<NSString *> *)subTitlesForPageViewController
{
    return nil;
}

- (NSArray *)iconImageForPageViewController
{
    return nil;
}

- (NSArray *)selectedIconImagePageViewController
{
    return nil;
}

- (YSSegmentStyle *)segmentStyleForPageViewController
{
    return [YSSegmentStyle new];
}

- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index;
{
    return nil;
}

- (void)adjustSegementItem:(YSSegmentItem *)item;
{
    
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
