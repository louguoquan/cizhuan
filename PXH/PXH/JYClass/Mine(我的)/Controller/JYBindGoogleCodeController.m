//
//  JYBindGoogleCodeController.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBindGoogleCodeController.h"

static NSInteger const LineTag = 200;
static NSInteger const DotTag  = 300;

static NSInteger const passwordLength = 6;

@interface JYBindGoogleCodeController ()

@property(nonatomic,strong) JYPasswordTextFiled *textFiled;

@end

@implementation JYBindGoogleCodeController

-(JYPasswordTextFiled *)textFiled
{
    if (!_textFiled) {
        _textFiled = [[JYPasswordTextFiled alloc]initWithFrame:CGRectMake(30, 100, kScreenWidth-30*2, 50)];
//        _textFiled.secureTextEntry = YES;//隐藏文本
        _textFiled.tintColor = [UIColor clearColor];//隐藏光标
        _textFiled.textColor = [UIColor clearColor];//隐藏内容
        _textFiled.font = [UIFont systemFontOfSize:0];
        [_textFiled becomeFirstResponder];
        _textFiled.keyboardType = UIKeyboardTypeNumberPad;
        [_textFiled addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
        [_textFiled sendActionsForControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_textFiled];
    }
    return _textFiled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    self.textFiled.backgroundColor = self.view.backgroundColor;
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    navigationLabel.text = @"谷歌验证码";
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

-(void)textFiledEdingChanged
{
//    [self.textFiled.text enumerateSubstringsInRange:NSMakeRange(0, self.textFiled.text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//
//        NSLog(@"\n++++subString: %@, subRange:(%@), encTange:(%@)\n", substring, NSStringFromRange(substringRange), NSStringFromRange(enclosingRange));
//    }];
}

@end


@implementation JYPasswordTextFiled

//static NSInteger const LineTag = 200;
//static NSInteger const DotTag  = 300;

//static NSInteger const passwordLength = 6;
static NSInteger const lineGapWidth = 12;

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }

    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat lineWidth = (frame.size.width - lineGapWidth*(passwordLength-1)) / passwordLength;
    CGFloat lineHeight = 2;
    
    for (int i=0; i<passwordLength; i++) {
        
        UIView *lineView = (UILabel *)[self viewWithTag:LineTag + i];
        if (!lineView) {
            lineView = [[UIView alloc] init];
            lineView.tag = LineTag + i;
            [self addSubview:lineView];
        }
//        lineView.backgroundColor = [UIColor grayColor];
        lineView.frame = CGRectMake((lineWidth+lineGapWidth)*i, frame.size.height - lineHeight, lineWidth, lineHeight);
        lineView.dk_backgroundColorPicker = DKColorPickerWithKey(GOOGLELINEBG);
        
        UILabel *dotLab = (UILabel *)[self viewWithTag:DotTag + i];
        if (!dotLab) {
            dotLab = [[UILabel alloc] init];
            dotLab.textAlignment = NSTextAlignmentCenter;
            dotLab.font = [UIFont systemFontOfSize:25];
            dotLab.tag = DotTag + i;
            [self addSubview:dotLab];
        }
//        dotLab.backgroundColor = [UIColor blackColor];
        dotLab.frame = CGRectMake(0, 0, 30, 30);
        dotLab.center = CGPointMake((lineWidth+lineGapWidth)*i + lineWidth/2, frame.size.height/2);
        dotLab.dk_textColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    }
}

//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController){
        menuController.menuVisible = NO;
    }
    return NO;
}

#pragma mark -- UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length>(passwordLength-1) && ![string isEqualToString:@""]) {
        NSLog(@"密码仅限%ld位", passwordLength);
        return NO;
    }
    
    //设置光标始终在文末
    UITextRange *selRange = textField.selectedTextRange;
    UITextPosition *start = [textField positionFromPosition:selRange.start inDirection:UITextLayoutDirectionRight offset:textField.text.length];
    if (start) {
        [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:start]];
    }
    
    //获取光标位置
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:textField.selectedTextRange.start];
    if ([string isEqualToString:@""]) {
        location -= 1;
    }

    UIView *lineView = [textField viewWithTag:LineTag+location];
    if ([string isEqualToString:@""]) {
        lineView.dk_backgroundColorPicker = DKColorPickerWithKey(GOOGLELINEBG);
    }else{
        lineView.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    }

    UILabel *dotLab = (UILabel *)[textField viewWithTag:DotTag+location];
    dotLab.text = string;
    
    return YES;
}

//正则只能输入数字,length位的数字
- (BOOL)lx_checkNumber:(NSString *)number length:(NSUInteger)lengths
{
    NSString *pattern = (lengths==0)?@"^[0-9]*$":[NSString stringWithFormat:@"^[0-9]{%ld}", lengths];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

@end
