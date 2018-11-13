//
//  YSEditImageItem.m
//  ZSMMember
//
//  Created by yu on 16/8/15.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSEditImageItem.h"

@interface YSEditImageItem ()

@property (nonatomic, strong) UIImageView   *contentImageView;

@property (nonatomic, strong) UIButton  *deleteButton;

@end

@implementation YSEditImageItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.size = CGSizeMake(20, 20);
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{    
    WS(weakSelf);
    _contentImageView = [UIImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(10, 0, 0, 10));
    }];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setImage:[UIImage imageNamed:@"cut_down"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@20);
        make.top.right.equalTo(weakSelf);
    }];
    
    _editEnable = YES;
}

- (void)setContentImage:(UIImage *)contentImage
{
    _contentImage = contentImage;
    
    _contentImageView.image = _contentImage;
}

- (void)setEditEnable:(BOOL)editEnable
{
    _editEnable = editEnable;
    
    _deleteButton.hidden = !_editEnable;
}

- (void)deleteImage
{
    if (_block) {
        _block(0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
