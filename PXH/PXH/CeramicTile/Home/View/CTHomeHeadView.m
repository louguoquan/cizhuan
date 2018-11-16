//
//  CTHomeHeadView.m
//  PXH
//
//  Created by louguoquan on 2018/11/12.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTHomeHeadView.h"
#import "SDCycleScrollView.h"

@interface CTHomeHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)SDCycleScrollView *cycleScrollViewTwo;

@end

@implementation CTHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    //轮播图
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
//    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [self addSubview:_cycleScrollView];
    
    
    NSArray *titleArray = @[@"热点排行",@"铺贴助手",@"名师讲堂",@"工程找砖"];
    
    CGFloat w = kScreenWidth/4.0f;
    CGFloat h = w ;
    for (int i = 0; i<4; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(w*(i%4), 150+h*(i/4), w, h)];
        view.tag = 1000+i;
        [self addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        UIImageView *imageView = [[UIImageView alloc]init];
                imageView.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1.0];
//        imageView.image = [UIImage imageNamed:imgarray[i]];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.width.height.mas_offset(60);
            make.top.equalTo(view).offset(20);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = HEX_COLOR(@"#333333");
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.height.mas_offset(15);
        }];
        

        
    }

    
    _cycleScrollViewTwo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kScreenWidth/4.0f+150+10, kScreenWidth, 80) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollViewTwo.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollViewTwo.autoScrollTimeInterval = 5.0;
    _cycleScrollViewTwo.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollViewTwo.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollViewTwo.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollViewTwo.currentPageDotColor = [UIColor redColor];
    //    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [self addSubview:_cycleScrollViewTwo];
    
    
    
    
}


- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (self.CTHomeHeadViewSetionSelect) {
        self.CTHomeHeadViewSetionSelect(tap.view.tag - 1000);
    }
    
    
}

#pragma mark ----- Action -----

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了%zd轮播图",index);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
