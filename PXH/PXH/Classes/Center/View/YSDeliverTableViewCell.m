//
//  YSDeliverTableViewCell.m
//  PXH
//
//  Created by futurearn on 2017/11/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDeliverTableViewCell.h"

@interface YSDeliverTableViewCell()

//@property (nonatomic, strong)UILabel *yearlabel;
//@property (nonatomic, strong)UILabel *timelabel;

@end

@implementation YSDeliverTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setRow:(NSInteger)row
{
    _row = row;
}

- (void)setDeliver:(YSDeliver *)deliver
{
    _deliver = deliver;
    [self initWithSubViews];
}

- (void)initWithSubViews
{
    NSArray *timeArray = [_deliver.time componentsSeparatedByString:@" "];
    UILabel *yearlabel = [UILabel new];
    yearlabel.font = [UIFont systemFontOfSize:15];
    yearlabel.textColor = HEX_COLOR(@"#333333");
    yearlabel.text = [timeArray firstObject];
    [self.contentView addSubview:yearlabel];
    [yearlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.centerY.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    UILabel *timelabel = [UILabel new];
    timelabel.font = [UIFont systemFontOfSize:13];
    timelabel.textColor = HEX_COLOR(@"#333333");
    timelabel.textAlignment = NSTextAlignmentCenter;
    timelabel.text = [timeArray lastObject];
    [self.contentView addSubview:timelabel];
    [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(yearlabel);
        make.top.mas_equalTo(yearlabel.mas_bottom).offset(5);
    }];
    
    UIImageView *iconImage = [UIImageView new];
    iconImage.contentMode = UIViewContentModeScaleAspectFit;
    if (_row == 0) {
        iconImage.image = [UIImage imageNamed:@"end"];
    } else {
        iconImage.image = [UIImage imageNamed:@"process"];
    }
    [self.contentView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(yearlabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(57);

    }];
    
    if (_row != 0) {
        UIView *toplineView = [UIView new];
        toplineView.backgroundColor = HEX_COLOR(@"#cccccc");
        [self.contentView addSubview:toplineView];
        [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(iconImage);
            make.top.offset(0);
            make.bottom.mas_equalTo(iconImage.mas_top);
            make.width.mas_equalTo(1);
            
        }];
    }
    
    if (_row != 2) {
        UIView *bottomlineView = [UIView new];
        bottomlineView.backgroundColor = HEX_COLOR(@"#cccccc");
        [self.contentView addSubview:bottomlineView];
        [bottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(iconImage);
            make.bottom.offset(0);
            make.top.mas_equalTo(iconImage.mas_bottom);
            make.width.mas_equalTo(1);
            
        }];
    }
    
    NSString *memo = _deliver.memo;
    CGRect rect = [self getHeight:memo];
    UILabel *contentlabel = [UILabel new];
    contentlabel.font = [UIFont systemFontOfSize:15];
    contentlabel.numberOfLines = 0;
    contentlabel.text = memo;
    contentlabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:contentlabel];
    [contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(iconImage.mas_right).offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(rect.size.height);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 动态获取高度
- (CGRect)getHeight:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(ScreenWidth - 222, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return rect;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
