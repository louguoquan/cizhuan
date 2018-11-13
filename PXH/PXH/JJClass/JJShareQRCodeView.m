//
//  JJShareQRCodeView.m
//  PXH
//
//  Created by louguoquan on 2018/10/29.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "JJShareQRCodeView.h"
#import "QRCodeImage.h"
@interface JJShareQRCodeView ()

@property (nonatomic, strong) NSString *product;

@property (nonatomic, weak) UIView *bgView;

@end

@implementation JJShareQRCodeView

- (instancetype)initWithProduct:(NSString *)product limitID:(NSString *)limitID {
    
    self = [super init];
    if (self) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kScreenHeight);
        }];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            [self hide];
        }]];
        
        UIToolbar *bgView = [UIToolbar new];
        bgView.barStyle = UIBarStyleBlack;
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView *view = [UIView new];
        self.bgView = view;
        view.backgroundColor = HEX_COLOR(@"#F7F7F7");
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.left.offset(25);
        }];
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.textColor = HEX_COLOR(@"#333333");
        nameLabel.text = @"12313";
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.numberOfLines = 0;
        [view addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(20);
            make.right.offset(-15);
        }];
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
        
//        //后台维护的分享大图
//        if (product.shareImage == nil) {
//            [imageView sd_setImageWithURLString:product.detailImage placeholder:[UIImage imageNamed:@"moren"]];
//        } else {
//            [imageView sd_setImageWithURLString:product.shareImage placeholder:[UIImage imageNamed:@"moren"]];
//        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:product]];
        
        NSString *shareURL = [NSString stringWithFormat:@"http://admin.ysjkj.net/share.png"];
        //        NSString *shareURL = [NSString stringWithFormat:@"http://weixin.test-haowukongtou.com/authorizationPage.html?param=%zd-%@-%@-%@", limitID ? 4 : 3, [SDAccount sharedAccount].ID, product.ID, limitID ? : @"0"];
        
        QRCodeImage *image = [QRCodeImage codeImageWithString:shareURL size:90];
        
        UIImageView *QRCodeView = [UIImageView new];
        QRCodeView.image = image;
        [view addSubview:QRCodeView];
        
        UILabel *priceLabel = [UILabel new];
        priceLabel.textColor = HEX_COLOR(@"#333333");
        priceLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:priceLabel];
        
//        priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.currentPrice];
        
        UILabel *noticeLabel = [UILabel new];
        noticeLabel.textColor = HEX_COLOR(@"#333333");
        noticeLabel.font = [UIFont systemFontOfSize:9];
        [view addSubview:noticeLabel];
        
        noticeLabel.text = @"长按二维码扫码购买";
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(nameLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(imageView.mas_width);
        }];
        
        [QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(imageView.mas_bottom).offset(20);
            make.width.height.mas_equalTo(90);
            make.bottom.offset(-20);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(QRCodeView.mas_right).offset(25);
            make.top.equalTo(QRCodeView);
        }];
        
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLabel);
            make.top.equalTo(priceLabel.mas_bottom).offset(20);
        }];
        
        UIButton *saveButton = [UIButton new];
        [saveButton setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [saveButton setTitle:@"保存图片到相册" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveButton];
        
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(view.mas_bottom).offset(20);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)saveImage {
    UIImage *image = [_bgView snapshotImage];
    if (self.JJShareQRCodeViewClick) {
        self.JJShareQRCodeViewClick(image);
    }

//    [MBProgressHUD showSuccessMessage:@"保存成功" toView:self];
}


@end
