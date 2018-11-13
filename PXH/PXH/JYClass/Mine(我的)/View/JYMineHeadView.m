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
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleLab.mas_bottom).mas_offset(10.f);
        make.top.mas_equalTo(10.f);
        make.left.mas_equalTo(27.f);
        make.height.width.mas_equalTo(50.f);
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
        _headImgView.layer.cornerRadius = 25.0f;
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
        _nameLab.font = [UIFont systemFontOfSize:15];
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
        _numLab.font = [UIFont systemFontOfSize:15];
        _numLab.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
        
        [self addSubview:_numLab];
    }
    return _numLab;
}


-(void)selHeadPhoto
{
//    !_selHeadPhotoBlock?:_selHeadPhotoBlock();
}

- (void)pushLogin
{
    !_selLoginBlock?:_selLoginBlock();
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
