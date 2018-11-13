//
//  JYGuideController.m
//  PXH
//
//  Created by LX on 2018/6/21.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYGuideController.h"
#import "YSMainTabBarViewController.h"

@interface JYGuideController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong , nonatomic)UICollectionView  *collectionView;
@property (strong , nonatomic)UIPageControl     *pageControl;
@property (nonatomic, strong) UIButton          *skipButton;

/** 图片数组 */
@property (nonatomic, copy) NSArray             *imgArray;
/** 小圆点选中颜色 */
@property (nonatomic, strong) UIColor           *selPageColor;
/** 是否显示跳过按钮, 默认不显示 */
@property (nonatomic, assign) BOOL              showSkip;
/** 是否显示page小圆点, 默认不显示 */
@property (nonatomic, assign) BOOL              showPageCountrol;

@end

static NSString *GuideCellID = @"JYGuideCell_ID";

@implementation JYGuideController


- (void)setUpAttribute:(void(^)(NSArray **imageArray, UIColor **selPageColor, BOOL *showSkip, BOOL *showPageCountrol))baseSettingBlock
{
    NSArray     *imageArray;
    UIColor     *selPageColor;
    BOOL        showSkip;
    BOOL        showPageCountrol;
    
    if (baseSettingBlock) {
        baseSettingBlock(&imageArray, &selPageColor, &showSkip, &showPageCountrol);
        
        self.imgArray = imageArray;
        self.selPageColor = selPageColor;
        self.showSkip = showSkip;
        self.showPageCountrol = showPageCountrol;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.skipButton setTitle:@"跳过" forState:0];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuideCellID forIndexPath:indexPath];
    cell.contentImgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    cell.beginSupBtn.hidden = !(indexPath.row == _imgArray.count-1);
    cell.beginSupBlock = ^{
        [self restoreRootViewController:YSMainTabBarViewController.new];
    };
    
    return cell;
}

//滑到最后一页再左滑动就切换控制器
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_imgArray.count<2) return;//一张图或没有直接返回
    _collectionView.bounces = (scrollView.contentOffset.x > (_imgArray.count-2)*ScreenWidth) ? YES:NO;
    
    if (scrollView.contentOffset.x > (_imgArray.count-1)*ScreenWidth) {
        [self restoreRootViewController:YSMainTabBarViewController.new];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!_showPageCountrol) return;
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}


#pragma mark - Action

-(void)skipAction:(UIButton *)sender
{
    [self restoreRootViewController:YSMainTabBarViewController.new];
}


- (void)restoreRootViewController:(UIViewController *)rootViewController {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
        
    } completion:nil];
}


#pragma mark - Set

-(void)setShowSkip:(BOOL)showSkip
{
    _showSkip = showSkip;
    self.skipButton.hidden = !_showSkip;
}

-(void)setShowPageCountrol:(BOOL)showPageCountrol
{
    _showPageCountrol = showPageCountrol;
    self.pageControl.hidden = !_showPageCountrol;
}


#pragma mark - 懒加载

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:JYGuideCell.class forCellWithReuseIdentifier:GuideCellID];
        
        [self.view insertSubview:_collectionView atIndex:0];
    }
    return _collectionView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, ScreenHeight*0.9, ScreenWidth, 35);
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = _imgArray.count;
        _pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
        _pageControl.currentPageIndicatorTintColor = (_selPageColor)?_selPageColor:UIColor.darkGrayColor;
        
//        [_pageControl setValue:[UIImage imageNamed:@"pageControl_sel"] forKeyPath:@"currentPageImage"];
//        [_pageControl setValue:[UIImage imageNamed:@"pageControl"] forKeyPath:@"pageImage"];
        
        [self.view addSubview:_pageControl];
    }
    
    return _pageControl;
}

-(UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(ScreenWidth - 85, 40, 65, 30);
        [_skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        
        [self.view addSubview:_skipButton];
    }
    return _skipButton;
}

@end


@implementation JYGuideCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _contentImgView = [[UIImageView alloc] init];
        [self insertSubview:_contentImgView atIndex:0];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentImgView.frame = self.bounds;
}


-(void)setBeginSupBtnImage:(id)beginSupBtnImage
{
    _beginSupBtnImage = beginSupBtnImage;
    if (beginSupBtnImage) {
        [self.beginSupBtn sizeToFit];
        
        [self.beginSupBtn setTitle:@"" forState:0];
        
        BOOL isImg = [[beginSupBtnImage class] isKindOfClass:UIImage.class];
        UIImage *image = isImg ? (UIImage *)beginSupBtnImage : [UIImage imageNamed:@"beginSupBtnImage"];
        [self.beginSupBtn setImage:image forState:0];
        
        self.beginSupBtn.center = CGPointMake(ScreenWidth*0.5, ScreenHeight*0.9);
    }
}

- (void)btnginSupAction
{
    !_beginSupBlock?:_beginSupBlock();
}


-(UIButton *)beginSupBtn
{
    if (!_beginSupBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        btn.hidden = YES;
        btn.backgroundColor = [UIColor colorWithRed:77/255.0 green:152/255.0 blue:238/255.0 alpha:1.0];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [btn setTitle:@"立即体验" forState:0];
        [btn addTarget:self action:@selector(btnginSupAction) forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(ScreenWidth*0.85, 50.f);
        btn.center = CGPointMake(ScreenWidth*0.5, ScreenHeight*0.85);
        [self addSubview:btn];
        
        _beginSupBtn = btn;
    }
    return _beginSupBtn;
}

@end
