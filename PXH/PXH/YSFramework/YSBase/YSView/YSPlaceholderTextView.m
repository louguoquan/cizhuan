//
//  YSPlaceholderTextView.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPlaceholderTextView.h"

@interface YSPlaceholderTextView ()

@end

@implementation YSPlaceholderTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.placeholderColor = [UIColor darkTextColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderFont = font;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;

    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark - Private

- (void)textDidChangeNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!_placeholder || self.text.length > 0) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = self.textAlignment;
    
    CGRect targetRect = CGRectMake(5, 8 + self.contentInset.top, self.frame.size.width - self.contentInset.left, self.frame.size.height - self.contentInset.top);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[NSFontAttributeName] = _placeholderFont;
    parameters[NSForegroundColorAttributeName] = _placeholderColor;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_placeholder attributes:parameters];
    [attributedString drawInRect:targetRect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
