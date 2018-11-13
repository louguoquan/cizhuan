//
//  JYRechargeNoticeView.m
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYRechargeNoticeView.h"


@interface JYRechargeNoticeView ()
{
    NSString    *noticeContentstr;
}

@property (nonatomic, strong) UIButton      *afterPromptBtn;

@end


@implementation JYRechargeNoticeView

- (instancetype)initWithNoticeContent:(NSString *)content
{
    self = [super init];
    if (self) {
        noticeContentstr = content;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    self.width = kScreenWidth - 70;
    
    CGFloat Y = 0;

    UIButton *noticeBtn = [self creatButton:15.f titleColor:DKColorPickerWithKey(TEXT) image:[UIImage imageNamed:@"prompt"] selImage:nil title:@"充币须知" action:nil];
    noticeBtn.userInteractionEnabled = NO;
    noticeBtn.frame = CGRectMake(0, Y, self.width, 44.f);
    [self addSubview:noticeBtn];

    Y += noticeBtn.height;
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, Y, self.width, 2)];
    topLine.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    [self addSubview:topLine];

    Y += topLine.height;
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(15, Y+15, self.width-15*2, 0)];
    countLab.numberOfLines = 0;
    countLab.font = [UIFont systemFontOfSize:13.f];
    countLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    //行间距
    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:noticeContentstr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7.f];
    [paragraphStyle setLineBreakMode:countLab.lineBreakMode];
    [paragraphStyle setAlignment:countLab.textAlignment];
    [muArrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, noticeContentstr.length)];
    countLab.attributedText = muArrStr;
    [self addSubview:countLab];
    [countLab sizeToFit];

    Y = CGRectGetMaxY(countLab.frame) + 50;
    _afterPromptBtn = [self creatButton:12.f titleColor:DKColorPickerWithKey(NOTICESELBUTTONTITLECOLOR) image:[UIImage imageNamed:@"box_NoSel"] selImage:[UIImage imageNamed:@"box_Sel"] title:@"以后不再提示" action:@selector(afterForPromptAction:)];
    [self addSubview:_afterPromptBtn];
    [_afterPromptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Y);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(200);
    }];
    [_afterPromptBtn.superview layoutIfNeeded];

    Y = CGRectGetMaxY(_afterPromptBtn.frame);
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, Y, self.width, 1)];
    bottomLine.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    [self addSubview:bottomLine];

    Y = CGRectGetMaxY(bottomLine.frame);
    UIButton *cancelBtn = [self creatButton:15.f titleColor:DKColorPickerWithKey(LOGINBUTTONBG) image:nil selImage:nil title:@"我知道了" action:@selector(hidePromptAction)];
    cancelBtn.frame = CGRectMake(0, Y, self.width, 44);
    [self addSubview:cancelBtn];

    Y = CGRectGetMaxY(cancelBtn.frame);
    self.size = CGSizeMake(self.width, Y);
}

- (UIButton *)creatButton:(CGFloat)fontSize titleColor:(DKColorPicker)picker image:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title action:(nullable SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //相对于图片设置标题的偏移量
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setImage:image forState:0];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setTitle:title forState:0];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn dk_setTitleColorPicker:picker forState:0];
    
    return btn;
}

- (UIView *)creatLineView:(UIView *)topView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.width.equalTo(self);
        make.height.mas_equalTo(2.f);
    }];
    
    return lineView;
}

- (void)afterForPromptAction:(UIButton *)sender
{
    NSLog(@"以后是否提示");
    
    sender.selected = !sender.selected;
    
    !_afterForPromptBlock?:_afterForPromptBlock(sender.selected);
}

- (void)hidePromptAction
{
    NSLog(@"我知道了");
    
    [self hide];
}


@end
