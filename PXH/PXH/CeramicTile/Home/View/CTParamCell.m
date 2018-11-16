//
//  CTParamCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTParamCell.h"

@interface CTParamCell ()

@property (nonatomic,strong)UILabel *topTitleLabel;
@property (nonatomic,strong)UILabel *centerTitleLabel;


@end

@implementation CTParamCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {

    [self.contentView addSubview:self.topTitleLabel];
    [self.contentView addSubview:self.centerTitleLabel];
    
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_offset(20);
        make.width.mas_offset((kScreenWidth-45)/2.0);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topTitleLabel.mas_right).offset(15);
        make.height.mas_offset(20);
        make.width.mas_offset((kScreenWidth-45)/2.0);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    
    self.topTitleLabel.text = @"400x400mm";
    self.centerTitleLabel.text = @"400x800mm";
    
    

}

- (UILabel *)topTitleLabel
{
    if (!_topTitleLabel) {
        _topTitleLabel = [[UILabel alloc]init];
        _topTitleLabel.textColor = HEX_COLOR(@"#555555");
        _topTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _topTitleLabel;
}

- (UILabel *)centerTitleLabel
{
    if (!_centerTitleLabel) {
        _centerTitleLabel = [[UILabel alloc]init];
        _centerTitleLabel.textColor = HEX_COLOR(@"#555555");
        _centerTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _centerTitleLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
