//
//  JYSheetView.m
//  PXH
//
//  Created by LX on 2018/6/3.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYSheetView.h"

@interface JYSheetView ()

@property (nonatomic ,strong) NSArray      *itemTitleArr;
@property (nonatomic, strong) UIButton      *lastSelBtn;

@end

static NSInteger const Document_BaseTag = 1000;

@implementation JYSheetView

-(instancetype)initWithItemTitleArray:(NSArray *)titleArray selTypeBlock:(SelectTypeBlock)block
{
    self = [super init];
    if (self) {
        self.itemTitleArr = [titleArray mutableCopy];
        self.selBlock = block;
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    __block CGFloat H = 10;
    
    [self.itemTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = Document_BaseTag + idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [btn setTitle:obj forState:0];
        [btn addTarget:self action:@selector(selectItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(CELLTITLE) forState:0];
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVBG) forState:UIControlStateSelected];
        [btn dk_setBackgroundColorPicker:DKColorPickerWithKey(BUTTONBG)];
        
        btn.frame = CGRectMake(0, H, [UIScreen mainScreen].bounds.size.width, 50);
        
        if (idx < self.itemTitleArr.count-1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.tag = Document_BaseTag + self.itemTitleArr.count + idx;
            [self addSubview:lineView];
            lineView.dk_backgroundColorPicker = DKColorPickerWithKey(CELLLINE);
            lineView.frame = CGRectMake(0, CGRectGetMaxY(btn.frame), kScreenWidth, 1);
            
            H += 51;
        }else{
            [btn dk_setTitleColorPicker:DKColorPickerWithKey(CELLDETAILTEXT) forState:0];
            
            H += 50 + 10;
        }
    }];

    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - H, [UIScreen mainScreen].bounds.size.width, H);
}


- (void)selectItemAction:(UIButton *)sender
{
    self.lastSelBtn.selected = NO;
    sender.selected = !sender.selected;
    self.lastSelBtn = sender;
    
    [self hide];
    
    if ([sender.currentTitle isEqualToString:@"取消"]){
        sender.selected = NO;
        return;
    }
    
    !_selBlock?:_selBlock(sender.currentTitle, sender.tag-Document_BaseTag);
}

@end
