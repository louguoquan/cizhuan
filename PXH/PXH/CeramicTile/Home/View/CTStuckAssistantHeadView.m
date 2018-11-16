//
//  CTStuckAssistantHeadView.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTStuckAssistantHeadView.h"
#import "SDCycleScrollView.h"

@interface CTStuckAssistantHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *brandLabel;
@property (nonatomic,strong)UILabel *styleLabel;

@property (nonatomic,strong)UILabel *sizeLabel;
@property (nonatomic,strong)UILabel *wayLabel;
@property (nonatomic,strong)UILabel *colorLabel;
@property (nonatomic,strong)UILabel *materialLabel;

@property (nonatomic,strong)UIButton *selBtn;

@end

@implementation CTStuckAssistantHeadView

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
    //    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [self addSubview:_cycleScrollView];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.brandLabel];
    [self addSubview:self.styleLabel];
    [self addSubview:self.sizeLabel];
    [self addSubview:self.wayLabel];
    [self addSubview:self.colorLabel];
    [self addSubview:self.materialLabel];
    [self addSubview:self.selBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        make.height.mas_offset(15);
    }];
    
    
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.brandLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.styleLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    
    [self.wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandLabel.mas_right).offset(10);
        make.top.equalTo(self.brandLabel);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.styleLabel.mas_right).offset(10);
        make.top.equalTo(self.styleLabel);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    [self.materialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeLabel.mas_right).offset(10);
        make.top.equalTo(self.sizeLabel);
        make.height.mas_offset(15);
        make.width.mas_offset((kScreenWidth-30)/2.0);
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.titleLabel);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    
    
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = HEX_COLOR(@"#F9F4F8");
    [self addSubview:sectionView];
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_offset(40);
        make.top.equalTo(self.sizeLabel.mas_bottom).offset(30);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"相似推荐";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = HEX_COLOR(@"#999999");
    [sectionView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView).offset(10);
        make.centerY.equalTo(sectionView);
        make.height.mas_offset(20);
    }];
  
    self.titleLabel.text = @"马可波罗釉面砖LF36898";
    self.priceLabel.text = @"指导价:￥15.6-19.0";
    self.brandLabel.text = @"品牌:马可波罗";
    self.styleLabel.text = @"风格:欧式";
    self.sizeLabel.text = @"尺寸:400x400mm";
    self.wayLabel.text = @"用途:客厅";
    self.colorLabel.text = @"色系:米黄色色系";
    self.materialLabel.text = @"材质:不限";
    
    
    
    
}

- (UIButton *)selBtn
{
    if (!_selBtn) {
        _selBtn = [[UIButton alloc]init];
        [_selBtn setTitle:@"重新挑选" forState:0];
        [_selBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:0];
        [_selBtn setBackgroundColor:HEX_COLOR(@"#2E77F9")];
        _selBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _selBtn.layer.cornerRadius = 3;
        _selBtn.layer.masksToBounds = YES;
    }
    return _selBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = HEX_COLOR(@"#888888");
        _priceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _priceLabel;
}

- (UILabel *)brandLabel
{
    if (!_brandLabel) {
        _brandLabel = [[UILabel alloc]init];
        _brandLabel.textColor = HEX_COLOR(@"#888888");
        _brandLabel.font = [UIFont systemFontOfSize:13];
    }
    return _brandLabel;
}

- (UILabel *)styleLabel
{
    if (!_styleLabel) {
        _styleLabel = [[UILabel alloc]init];
        _styleLabel.textColor = HEX_COLOR(@"#888888");
        _styleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _styleLabel;
}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.textColor = HEX_COLOR(@"#888888");
        _sizeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _sizeLabel;
}

- (UILabel *)wayLabel
{
    if (!_wayLabel) {
        _wayLabel = [[UILabel alloc]init];
        _wayLabel.textColor = HEX_COLOR(@"#888888");
        _wayLabel.font = [UIFont systemFontOfSize:13];
    }
    return _wayLabel;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc]init];
        _colorLabel.textColor = HEX_COLOR(@"#888888");
        _colorLabel.font = [UIFont systemFontOfSize:13];
    }
    return _colorLabel;
}

- (UILabel *)materialLabel
{
    if (!_materialLabel) {
        _materialLabel = [[UILabel alloc]init];
        _materialLabel.textColor = HEX_COLOR(@"#888888");
        _materialLabel.font = [UIFont systemFontOfSize:13];
    }
    return _materialLabel;
}

@end
