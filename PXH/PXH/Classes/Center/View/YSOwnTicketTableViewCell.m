//
//  YSOwnTicketTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOwnTicketTableViewCell.h"

@interface YSOwnTicketTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel   *discountLabel;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *timeLabel;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation YSOwnTicketTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        self.type = 2;
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    
    self.bgImageView = [UIImageView new];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [[UIImage imageNamed:@"tiket_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
    [self.contentView addSubview:_bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(51);
    }];
    
    _logo = [UIImageView new];
    [_bgImageView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(33);
        make.centerY.equalTo(self.bgImageView);
        make.left.offset(24);
    }];
    
    _discountLabel = [UILabel new];
    _discountLabel.font = [UIFont systemFontOfSize:18];
    _discountLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:_discountLabel];
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(_logo.mas_right).offset(24);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.text = @"电子券";
    [_bgImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_discountLabel);
        make.left.equalTo(_discountLabel.mas_right).offset(15);
    }];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.layer.cornerRadius = 2;
    _commentButton.layer.borderWidth = 1;
    _commentButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _commentButton.layer.masksToBounds = YES;
    _commentButton.tag = _type;
    [_commentButton setTitle:@"使用" forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_commentButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//
//        [weakSelf.commentButton setTitle:@"待评价" forState:UIControlStateNormal];
//        if (_type == 1) {
//            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1), @"model":weakSelf.coupons}];
//        }
//        _type = 1;
//    }];
    [_bgImageView addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.right.offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImageView.mas_bottom).offset(-5);
        make.left.right.equalTo(_bgImageView);
        make.height.mas_equalTo(32);
    }];
    [self.contentView sendSubviewToBack:view];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(2.5);
        make.left.offset(10);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = HEX_COLOR(@"#999999");
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.right.offset(-10);
    }];
}
// type 状态  0 使用 1 已经评价（已使用） 2 已过期
- (void)buttonAction:(UIButton *)sender
{
    NSString *sectionStr = [NSString stringWithFormat:@"%ld", _section];
    self.buttonAction(@{@"coupons" : _coupons, @"section": sectionStr});
//    if (_type == 2) {
////        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1), @"model":weakSelf.coupons}];
//
//    }
//    _type = 2;
}

- (void)setCoupons:(YSCoupons *)coupons {
    _coupons = coupons;
    
    _discountLabel.text = _coupons.title;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_coupons.shopLogo] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _coupons.shopName;
    
    _timeLabel.text = [NSString stringWithFormat:@"有效期至:%@", _coupons.endDate];
    _bgImageView.image = [[UIImage imageNamed:@"tiket_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
    _commentButton.userInteractionEnabled = YES;

    //status 0 未使用 1已使用 2已过期
    if (_coupons.isComment == 1) {
        [_commentButton setTitle:@"已评价" forState:0];
        _commentButton.userInteractionEnabled = NO;
        _bgImageView.image = [[UIImage imageNamed:@"ticket_expire"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
    } else {
        if (_coupons.status == 0) {
            [_commentButton setTitle:@"使用" forState:UIControlStateNormal];
        } else if (_coupons.status == 1) {
            [_commentButton setTitle:@"评价" forState:UIControlStateNormal];

        } else {
            [_commentButton setTitle:@"已过期" forState:0];
            _commentButton.userInteractionEnabled = NO;
            _bgImageView.image = [[UIImage imageNamed:@"ticket_expire"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
        }
    }
    
//    if (_coupons.isComment == 0) {
//        switch (_coupons.status) {
//            case 0:
//            {
//                [_commentButton setTitle:@"使用" forState:UIControlStateNormal];
//            }
//                break;
//            case 1:
//            {
//                [_commentButton setTitle:@"评价" forState:UIControlStateNormal];
//            }
//                break;
//            case 2:
//            {
//                [_commentButton setTitle:@"已过期" forState:0];
//                _commentButton.userInteractionEnabled = NO;
//                _bgImageView.image = [[UIImage imageNamed:@"ticket_expire"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeTile];
//
//            }
//                break;
//            default:
//                break;
//        }
//    }
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
