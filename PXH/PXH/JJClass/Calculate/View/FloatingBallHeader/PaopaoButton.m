//
//  PaopaoButton.m
//  YiLink
//
//  Created by CygMac on 2018/6/2.
//  Copyright © 2018年 xunku_mac. All rights reserved.
//

#import "PaopaoButton.h"
#import <Masonry/Masonry.h>

@interface PaopaoButton ()

@property (nonatomic, strong) UIImageView *topImageView;
@end

@implementation PaopaoButton

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.centerLabel];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width);
        }];
        
        [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.topImageView);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(15);
        }];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topImageView.mas_bottom).offset(4);
            make.left.right.equalTo(self);
            make.centerX.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setPaopaoImage:(UIImage *)image {
    self.topImageView.image = image;
}

- (void)setTitle:(NSString *)title {
    self.centerLabel.text = title;
}

#pragma mark - Get

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
    }
    return _topImageView;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        _bottomLabel.textColor = GoldColor;
        _bottomLabel.text = CoinNameChange;
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.adjustsFontSizeToFitWidth = YES;
        _bottomLabel.minimumFontSize = 0.1;
    }
    return _bottomLabel;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        _centerLabel.font = [UIFont systemFontOfSize:12];
        _centerLabel.textColor = HEX_COLOR(@"#333333");
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}

@end
