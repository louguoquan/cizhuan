//
//  JJHomeCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJHomeCell.h"


@interface JJHomeCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *commitLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *img;

@end


@implementation JJHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.commitLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.titleLabel);
        make.height.mas_offset(150);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.img.mas_bottom).offset(5);
        make.width.height.mas_offset(15);
    }];
    
//    [self.commitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.typeLabel.mas_right).offset(10);
//        make.top.equalTo(self.img.mas_bottom).offset(5);
//        make.height.mas_offset(15);
//    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.top.equalTo(self.img.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    
}


- (void)setModel:(JJHomeModel *)model
{
    self.titleLabel.text = model.title;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    if (model.image.length != 0) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:model.image]];
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        self.img.layer.masksToBounds = YES;
        self.typeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        }];
    }else{
        self.img.hidden = YES;
        [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
        self.typeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
//    self.commitLabel.text = @"528评论";
    
    self.timeLabel.text = model.time;
    
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textColor = HEX_COLOR(@"#ef0022");
        _typeLabel.text = @"热";
        _typeLabel.layer.cornerRadius = 3.0;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.layer.borderWidth = 1.0f;
        _typeLabel.layer.borderColor = HEX_COLOR(@"#ef0022").CGColor;
    }
    return _typeLabel;
}

- (UILabel *)commitLabel
{
    if (!_commitLabel) {
        _commitLabel = [[UILabel alloc]init];
        _commitLabel.font = [UIFont systemFontOfSize:13];
        _commitLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _commitLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}

- (UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
