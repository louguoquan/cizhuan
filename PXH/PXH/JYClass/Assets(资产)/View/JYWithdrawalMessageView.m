//
//  JYWithdrawalMessageView.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYWithdrawalMessageView.h"
#import "JYWithdrawNoticeModel.h"

@interface JYWithdrawalMessageView ()



@end

@implementation JYWithdrawalMessageView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"供应商收购";
    label1.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label1.font = [UIFont systemFontOfSize:15];
    [self addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(17);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"1";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.dk_backgroundColorPicker = DKColorPickerWithKey(KLINEHEADTEXTRED);
    label2.dk_textColorPicker = DKColorPickerWithKey(AssetsBtnTEXT);
    label2.font = [UIFont systemFontOfSize:15];
    [self addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(18);
        make.left.equalTo(self).offset(20);
        make.width.height.mas_equalTo(24);
    }];
    
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"添加以下任一AsFinex平台认证供应商或者QQ";
    label3.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label3.font = [UIFont systemFontOfSize:13];
    [self addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2);
        make.left.equalTo(label2.mas_right).offset(8);
        make.height.mas_equalTo(14);
    }];
    
    
    UIView *baseImageView = [UIView new];
    [self addSubview:baseImageView];
    
    CGFloat height = 0.0f;
    CGFloat width = 0.0f;
    for (int i = 0; i<3; i++) {
        
        CGFloat insW = 20;
        CGFloat insH = 20;
        CGFloat w = (kScreenWidth - insW * 4 - 20)/3.0;
        CGFloat h = w+40;
        CGFloat x = insW+(insW+w)*i;
        CGFloat y = (h+insH)*(i/3);
        
        width = w;
        
        UIView *base = [UIView new];
        base.frame = CGRectMake(x, y, w, h);
        [baseImageView addSubview:base];
        base.tag = 1100+i;
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 900+i;
        imageView.backgroundColor = [UIColor grayColor];
        [base addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(base);
            make.height.mas_equalTo(w);
        }];
        
        UILabel *labeltemp = [UILabel new];
        labeltemp.text = @"微信号：121312\n微信工会上";
        labeltemp.tag = 1000+i;
        labeltemp.font = [UIFont systemFontOfSize:12];
        labeltemp.numberOfLines = 0;
        [labeltemp sizeToFit];
        [base addSubview:labeltemp];
        [labeltemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.left.right.equalTo(base);
            make.height.greaterThanOrEqualTo(@12);
        }];
        
        height = h;
        
        
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.minimumPressDuration = 1.0;
        base.userInteractionEnabled  = YES;
        [base addGestureRecognizer:tap];
    }
    
    
    [baseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(11);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(height);
        
    }];
    
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.text = @"2";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.dk_backgroundColorPicker = DKColorPickerWithKey(KLINEHEADTEXTRED);
    label4.dk_textColorPicker = DKColorPickerWithKey(AssetsBtnTEXT);
    label4.font = [UIFont systemFontOfSize:15];
    [self addSubview:label4];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseImageView.mas_bottom).offset(50);
        make.left.equalTo(self).offset(20);
        make.width.height.mas_equalTo(24);
    }];
    
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.text = @"跟供应商通过法币交易卖出";
    label5.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label5.font = [UIFont systemFontOfSize:13];
    [self addSubview:label5];
    
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label4);
        make.left.equalTo(label2.mas_right).offset(8);
        make.height.mas_equalTo(14);
    }];
    
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.text = @"与供应商通过法币交易卖出";
    label6.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label6.font = [UIFont systemFontOfSize:11];
    label6.layer.borderWidth = 1.0;
    label6.layer.borderColor = HEX_COLOR(@"#D9DADB").CGColor;
    [self addSubview:label6];
    
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(label5.mas_bottom).offset(27);
        make.height.mas_equalTo(24);
    }];
    
    
    UILabel *label7 = [[UILabel alloc]init];
    label7.text = @"向供应商账号转币";
    label7.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label7.font = [UIFont systemFontOfSize:11];
    label7.layer.borderWidth = 1.0;
    label7.layer.borderColor = HEX_COLOR(@"#D9DADB").CGColor;
    [self addSubview:label7];
    
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label6.mas_right).offset(15);
        make.top.equalTo(label6);
        make.height.mas_equalTo(24);
    }];
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.text = @"收款 交易完成";
    label8.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    label8.font = [UIFont systemFontOfSize:11];
    label8.layer.borderWidth = 1.0;
    label8.layer.borderColor = HEX_COLOR(@"#D9DADB").CGColor;
    [self addSubview:label8];
    
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label7.mas_right).offset(15);
        make.top.equalTo(label7);
        make.height.mas_equalTo(24);
    }];
    
    
    UILabel *label9 = [[UILabel alloc]init];
    label9.text = @"以上供应商均已向AsFinex平台缴纳保证金，用户可放心进行交易";
    label9.dk_textColorPicker = DKColorPickerWithKey(AssetsNoteTEXT);
    label9.textAlignment = NSTextAlignmentCenter;
    label9.layer.borderWidth = 1.0;
    label9.layer.borderColor = HEX_COLOR(@"#E01434").CGColor;
    label9.font = [UIFont systemFontOfSize:11];
    [self addSubview:label9];
    
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.top.equalTo(label8.mas_bottom).offset(12);
        make.height.mas_equalTo(24);
    }];
    
    
    UILabel *label10 = [[UILabel alloc]init];
    label10.text = @"提现成法币请到右侧的【平台内转账进行操作】";
    label10.dk_textColorPicker = DKColorPickerWithKey(AssetsNoteTEXT);
    label10.font = [UIFont systemFontOfSize:13];
    [self addSubview:label10];
    
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.top.equalTo(label9.mas_bottom).offset(15);
        make.height.mas_equalTo(13);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.backgroundColor = [UIColor grayColor];
    [self addSubview:imageView1];
    imageView1.tag = 903;
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label10.mas_bottom).offset(18);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(width);
    }];
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
      tap.minimumPressDuration = 1.0;
    
    imageView1.userInteractionEnabled  = YES;
    [imageView1 addGestureRecognizer:tap];
    
    UILabel *label11 = [UILabel new];
    label11.text = @"有任何问题，请联系AsFinex微信客服";
    label11.font = [UIFont systemFontOfSize:12];
    label11.textAlignment = NSTextAlignmentCenter;
    label11.numberOfLines = 0;
    [label11 sizeToFit];
    [self addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.greaterThanOrEqualTo(@12);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    
    
}


- (void)tap:(UITapGestureRecognizer *)tap{
    
    //直接return掉，不在开始的状态里面添加任何操作，则长按手势就会被少调用一次了
    if (tap.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    if (self.array.count>0) {
       
        
        if (tap.view.tag>=1100) {
            
            JYWithdrawNoticeModel *model = self.array[tap.view.tag-1100];
            
            //  通用的粘贴板
            UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
            //  有些时候只想取UILabel的text中的一部分
            if (objc_getAssociatedObject(self, @"expectedText")) {
                pBoard.string = objc_getAssociatedObject(self, @"expectedText");
            } else {
                //  因为有时候 label 中设置的是attributedText
                //  而 UIPasteboard 的string只能接受 NSString 类型
                //  所以要做相应的判断
                
                pBoard.string = model.qqStr.length>0?model.qqStr:model.wxStr;
                
                [MBProgressHUD showText:model.qqStr.length>0?@"复制QQ号成功!":@"复制微信号成功!" toContainer:[UIApplication sharedApplication].keyWindow];
            }
            
            
        }else{
            
             JYWithdrawNoticeModel *model = self.array[tap.view.tag-900];
            //  通用的粘贴板
            UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
            //  有些时候只想取UILabel的text中的一部分
            if (objc_getAssociatedObject(self, @"expectedText")) {
                pBoard.string = objc_getAssociatedObject(self, @"expectedText");
            } else {
                //  因为有时候 label 中设置的是attributedText
                //  而 UIPasteboard 的string只能接受 NSString 类型
                //  所以要做相应的判断
                
                pBoard.string = model.qqStr.length>0?model.qqStr:model.wxStr;
                
                [MBProgressHUD showText:model.qqStr.length>0?@"复制QQ号成功!":@"复制微信号成功!" toContainer:[UIApplication sharedApplication].keyWindow];
            }
        }
    }
}


- (void)setArray:(NSArray *)array
{
 
    
    _array = array;
    
    if (array.count == 4) {
        for (int i = 0; i<array.count; i++) {
            
            JYWithdrawNoticeModel *model = array[i];
            
            UIImageView *imageView = [self viewWithTag:900+i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.qrImg] placeholderImage:[UIImage imageNamed:@"默认图"]];
            UILabel*label = [self viewWithTag:1000+i];
            NSString *str;
            
            if (i<3) {
                if (i == 0) {
                    str = @"供货商一";
                }else if (i == 1){
                    str = @"供货商二";
                }else if (i == 2){
                    str = @"供货商三";
                }
                label.text = [NSString stringWithFormat:@"%@\n%@",model.qqStr.length==0?[NSString stringWithFormat:@"微信号:%@",model.wxStr]:[NSString stringWithFormat:@"QQ号:%@",model.qqStr],str];
            }

        }
    }
    
    
    
}



@end
