//
//  YSGrowingTextView.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGrowingTextView.h"

@interface YSGrowingTextView ()<UITextViewDelegate>

/***文本输入框最高高度***/
@property (nonatomic, assign) NSInteger   textInputMaxHeight;

@end

@implementation YSGrowingTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];

        self.textViewMaxLine = 4;
        self.delegate = self;
    }
    return self;
}

- (void)setTextViewMaxLine:(NSInteger)textViewMaxLine
{
    _textViewMaxLine = textViewMaxLine;
    _textInputMaxHeight = ceil(self.font.lineHeight * _textViewMaxLine +
                               self.textContainerInset.top + self.textContainerInset.bottom);
}

#pragma mark - delegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat inputHeight = ceilf([self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height);
    
    self.scrollEnabled = inputHeight > _textInputMaxHeight && _textInputMaxHeight > 0;
    CGFloat height = 0;
    if (self.scrollEnabled) {
        height = _textInputMaxHeight;
    } else {
        height = inputHeight;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height).priorityMedium();
    }];
    
    if (self.block) {
        self.block(self.height);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.growingTextDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.growingTextDelegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
