//
//  JYMineHeadView.m
//  PXH
//
//  Created by LX on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMineHeadView.h"

@interface JYMineHeadView()

@property (nonatomic, strong) UILabel       *titleLab;
@property (nonatomic, strong) UILabel       *nameLab;
@property (nonatomic, strong) UILabel       *numLab;
@property (nonatomic, strong) UIImageView   *backgroundImg;
@property (nonatomic, strong) UIButton      *vipBtn;
@end


@implementation JYMineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    WS(weakSelf);
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kStatusBarHeight);
//        make.left.centerX.equalTo(weakSelf);
//        make.height.mas_equalTo(kNavigationBarHeight);
//    }];
    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleLab.mas_bottom).mas_offset(10.f);
//        make.top.mas_equalTo(10.f);
        make.left.mas_equalTo(27.f);
        make.centerY.equalTo(self.mas_centerY).mas_equalTo(-20.f);
        make.height.width.mas_equalTo(70.f);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.headImgView.mas_centerY).mas_offset(-3.f);
        make.left.equalTo(weakSelf.headImgView.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-10.f);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImgView.mas_centerY).mas_offset(3.f);
        make.left.equalTo(weakSelf.nameLab);
        make.right.mas_equalTo(-10.f);
    }];
    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImgView).mas_offset(10);
        make.right.equalTo(self).mas_equalTo(-20.0f);
        make.width.mas_equalTo(90.f);
        make.height.mas_equalTo(20.f);
        
    }];
    
    NSArray *titles = @[@"询价订单",@"消息中心",@"我的发表",@"我的收藏"];
    CGFloat btnWidth = 50;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 4*btnWidth)/5;
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blackColor];
        [self addSubview:button];
        
        UILabel *label = [UILabel new];
        label.text     = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font     = [UIFont systemFontOfSize:15];
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView.mas_bottom).mas_equalTo(30);
            make.left.equalTo(self).mas_equalTo(i*btnWidth + margin*(i+1));
            make.width.height.mas_equalTo(btnWidth);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).mas_equalTo(5);
            make.left.equalTo(self).mas_equalTo(i*btnWidth + margin*(i+1));
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(20);
        }];
        if (i == 0) {
            [button addTarget:self action:@selector(selOrder) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 1) {
            [button addTarget:self action:@selector(selMes) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 2) {
            [button addTarget:self action:@selector(selPub) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 3) {
            [button addTarget:self action:@selector(selCol) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}


-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"我的";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:18];
        _titleLab.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
        
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.layer.cornerRadius = 35.0f;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.image = [UIImage imageNamed:@"eth"];
        
        _headImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selHeadPhoto)];
        [_headImgView addGestureRecognizer:tap];
        
        [self addSubview:_headImgView];
    }
    return _headImgView;
}

-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:20];
        _nameLab.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
        
        
//        _nameLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLogin)];
        [_nameLab addGestureRecognizer:tap];
        
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

-(UILabel *)numLab
{
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textAlignment = NSTextAlignmentLeft;
        _numLab.font = [UIFont systemFontOfSize:17];
        _numLab.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
        _numLab.text = @"test";
        [self addSubview:_numLab];
    }
    return _numLab;
}
- (UIImageView *)backgroundImg{
    if (!_backgroundImg) {
        _backgroundImg = [UIImageView new];
        _backgroundImg.userInteractionEnabled = YES;
        _backgroundImg.backgroundColor = [UIColor redColor];
        [self addSubview:_backgroundImg];
    }
    return _backgroundImg;
}
- (UIButton *)vipBtn{
    if (!_vipBtn) {
        _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vipBtn setTitle:@"普通会员" forState:UIControlStateNormal];
        [_vipBtn setBackgroundColor:[UIColor blackColor]];
        
        [self addSubview:_vipBtn];
    }
    return _vipBtn;
}

-(void)selHeadPhoto
{
//    !_selHeadPhotoBlock?:_selHeadPhotoBlock();
}
- (void)selOrder{
    !_selOrderBlock?:_selOrderBlock();
}
- (void)selMes{
    !_selMesBlock?:_selMesBlock();
}
- (void)selPub{
    !_selPubBlock?:_selPubBlock();
}
- (void)pushLogin
{
    !_selLoginBlock?:_selLoginBlock();
}
- (void)selCol{
    !_selColBlock?:_selColBlock();
}

-(void)setHeadImg:(id)headImg
{
    _headImg = headImg;
    
    if ([headImg isKindOfClass:[UIImage class]]) {
        self.headImgView.image = headImg;
    }else{
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:headImg]];
    }
}


-(void)setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    
    if ([nameStr isEqualToString:@"注册/登录"]) {
        
        [self.nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImgView.mas_centerY);
            make.left.equalTo(self.headImgView.mas_right).mas_offset(15.f);
        }];
        
        self.nameLab.userInteractionEnabled = YES;
    }
    else {
        [self.nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImgView.mas_centerY).mas_offset(-3.f);
            make.left.equalTo(self.headImgView.mas_right).mas_offset(15.f);
        }];
        
        self.nameLab.userInteractionEnabled = NO;
    }
    
    [self layoutIfNeeded];
    
    self.nameLab.text = nameStr;
}

-(void)setNumStr:(NSString *)numStr
{
    _numStr = numStr;
    
    self.numLab.text = numStr;
}



@end
