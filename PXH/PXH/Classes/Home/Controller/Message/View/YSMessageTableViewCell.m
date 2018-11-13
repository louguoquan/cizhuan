//
//  YSMessageTableViewCell.m
//  PXH
//
//  Created by futurearn on 2017/12/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMessageTableViewCell.h"

@interface YSMessageTableViewCell()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation YSMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews
{
    UILabel *titlelabel = [UILabel new];
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.text = @"消息";
    titlelabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.top.offset(10);
        make.right.offset(-20);
        make.height.mas_equalTo(20);
        
    }];
    
    self.timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = BORDER_COLOR;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(titlelabel.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(titlelabel);
        
    }];
    
    self.messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_timeLabel.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(titlelabel);
        make.bottom.offset(-10);
        
    }];
}

- (void)setMessage:(YSMessage *)message
{
    _timeLabel.text = message.time;
    
    _messageLabel.text = message.message;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
