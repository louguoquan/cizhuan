//
//  CTTuiJianTableViewCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTTuiJianTableViewCell.h"

@interface CTTuiJianTableViewCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView  *imgView;
@property (nonatomic,strong)UILabel *commentLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end


@implementation CTTuiJianTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.titleLabel);
        make.height.mas_offset(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel);
        make.right.equalTo(self.timeLabel.mas_left).offset(-20);
        make.height.equalTo(self.timeLabel);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    
    self.titleLabel.text = @"大理石瓷砖不等于大理石大理石瓷砖不等于大理石大理石瓷砖不等于大理石大理石瓷砖不等于大理石大理石瓷砖不等于大理石";
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    self.imgView.backgroundColor = [UIColor redColor];
    
    self.commentLabel.text = @"869条评论";
    
    self.timeLabel.text = @"15分钟前";
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}

- (UIView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIView alloc]init];
    }
    return _imgView;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.font = [UIFont systemFontOfSize:11];
        _commentLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _commentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
