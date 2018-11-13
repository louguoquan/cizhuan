//
//  JYCellView.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYCellView.h"

@implementation JYCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    UIView *cellView = [[UIView alloc] init];
    cellView.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.font = [UIFont systemFontOfSize:15];
//    leftLab.text = leftTitle;
    [cellView addSubview:leftLab];
    leftLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellView);
        make.left.mas_equalTo(15.f);
        make.bottom.mas_equalTo(-1);
        make.width.mas_equalTo(60.f);
    }];
    
    
    UITextField *textField = [[UITextField alloc] init];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellView.height-1, cellView.width, 1)];
    lineView.dk_backgroundColorPicker = DKColorPickerWithKey(CELLLINEBG);
}

@end
