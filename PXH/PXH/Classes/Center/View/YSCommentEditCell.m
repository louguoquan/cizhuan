//
//  YSCommentEditCell.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCommentEditCell.h"

#import <HCSStarRatingView.h>
#import <IQTextView.h>
#import "YSEditImagesView.h"

@interface YSCommentEditCell ()<UITextViewDelegate>

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel       *nameLabel;

@property (nonatomic, strong) IQTextView    *contentTv;

@property (nonatomic, strong) YSEditImagesView      *imagesView;

@property (nonatomic, strong) HCSStarRatingView     *ratingView1;

@property (nonatomic, strong) HCSStarRatingView     *ratingView2;

@end

@implementation YSCommentEditCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WS(weakSelf);
    
    _logo = [UIImageView new];
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.clipsToBounds = YES;
    [self.contentView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(30);
        make.top.offset(10);
        make.left.offset(10);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#666666");
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.offset(-10);
        make.centerY.equalTo(_logo);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logo.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];

    _contentTv = [IQTextView new];
    _contentTv.delegate = self;
    _contentTv.font = [UIFont systemFontOfSize:13];
    _contentTv.textColor = HEX_COLOR(@"#333333");
    _contentTv.placeholder = @"说两句吧...";
    [self.contentView addSubview:_contentTv];
    [_contentTv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.height.equalTo(@60);
    }];
    
    _imagesView = [[YSEditImagesView alloc] initWithColumn:4 maxCount:9 addButtonImage:[UIImage imageNamed:@"comment_image_add"]];
    [self.contentView addSubview:_imagesView];
    [_imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentTv.mas_bottom);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    [_imagesView setBlock:^(){
        weakSelf.product.extImages = weakSelf.imagesView.images;
        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@"1", @"model":weakSelf.product}];
    }];

    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imagesView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];

    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#666666");
    label.text = @"产品评分";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.height.mas_equalTo(45);
        make.left.offset(10);
        make.width.mas_equalTo(90);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = HEX_COLOR(@"#666666");
    label1.text = @"服务评分";
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.height.mas_equalTo(45);
        make.left.offset(10);
        make.width.mas_equalTo(90);
        make.bottom.offset(0);
    }];
    
    _ratingView1 = [[HCSStarRatingView alloc] init];
    _ratingView1.maximumValue = 5;
    _ratingView1.continuous = YES;
    _ratingView1.emptyStarImage = [UIImage imageNamed:@"evaluate_star_grey"];
    _ratingView1.filledStarImage = [UIImage imageNamed:@"evaluate_star_new"];
    [_ratingView1 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        weakSelf.product.extScore1 = weakSelf.ratingView1.value;
    }];
    [self.contentView addSubview:_ratingView1];
    [_ratingView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.left.equalTo(label.mas_right);
        make.centerY.equalTo(label);
    }];
    
    _ratingView2 = [[HCSStarRatingView alloc] init];
    _ratingView2.maximumValue = 5;
    _ratingView2.continuous = YES;
    _ratingView2.emptyStarImage = [UIImage imageNamed:@"evaluate_star_grey"];
    _ratingView2.filledStarImage = [UIImage imageNamed:@"evaluate_star_new"];
    [_ratingView2 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        weakSelf.product.extScore2 = weakSelf.ratingView2.value;
    }];
    [self.contentView addSubview:_ratingView2];
    [_ratingView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.left.equalTo(label1.mas_right);
        make.centerY.equalTo(label1);
    }];
    
}

- (void)setProduct:(YSOrderProduct *)product {
    _product = product;
    
    _ratingView1.value = _product.extScore1;
    _ratingView2.value = _product.extScore2;
    
    _contentTv.text = _product.extContent;
    
    _imagesView.images = [NSMutableArray arrayWithArray:_product.extImages];
    [_imagesView updateImagesView];
    
    _nameLabel.text = _product.productName;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_product.productImage] placeholderImage:kPlaceholderImage];

}

#pragma mark - textView delegate
- (void)textViewDidChange:(UITextView *)textView
{
    _product.extContent = textView.text;
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
