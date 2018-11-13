//
//  YSSeckillViewCell.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSeckillViewCell.h"

#import "YSSeckillView.h"

@interface YSSeckillViewCell ()

@property (nonatomic, strong) YSSeckillView     *seckillView;

@end

@implementation YSSeckillViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = BACKGROUND_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _seckillView = [YSSeckillView new];
    _seckillView.type = 0;
    [self.contentView addSubview:_seckillView];
    [_seckillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(120.f);
    }];
}

- (void)setProduct:(YSSeckillProduct *)product {
    
    [self.contentView layoutIfNeeded];
    _product = product;
    
    [_seckillView setSeckillProduct:_product];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
