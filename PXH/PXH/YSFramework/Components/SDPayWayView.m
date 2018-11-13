
//
//  SDPayWayView.m
//  QingTao
//
//  Created by yu on 16/5/26.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "SDPayWayView.h"

@interface SDPayWayView ()

@property (nonatomic, copy) NSArray     *types;

@property (nonatomic, copy) NSMutableArray  *cells;

@end

@implementation SDPayWayView

- (instancetype)initWithTypes:(NSArray *)types
{
    self = [super init];
    if (self) {
        _types = types;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _cells = [NSMutableArray array];
    WS(weakSelf);
    UIView *lastView = nil;
    for (NSInteger i = 0; i < [_types count]; i ++) {
        SDPayWayCell *cell = [[SDPayWayCell alloc] initWithPayWay:[_types[i] integerValue] tapBlock:^(SDPayWay payway) {
            [weakSelf cellClick:payway];
        }];
        cell.userInteractionEnabled = YES;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom);
                make.left.right.height.equalTo(lastView);
            }else {
                make.top.left.right.equalTo(weakSelf);
                make.height.equalTo(@44);
            }
            if (i == [weakSelf.types count] - 1) {
                make.bottom.offset(0);
            }
        }];
        if (i != [weakSelf.types count] - 1) {
            UIView *lineView = [UIView new];
            lineView.backgroundColor = LINE_COLOR;
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_bottom).offset(-0.5);
                make.height.equalTo(@0.5);
                make.left.offset(10);
                make.right.offset(0);
            }];
        }
        lastView = cell;
        if (i == 0) {
            cell.selected = YES;
            _payWay = [_types[i] integerValue];
        }
        [_cells addObject:cell];
    }
}

- (void)cellClick:(SDPayWay)payway
{
    NSInteger index = [_types indexOfObject:@(payway)];
    
    SDPayWayCell *cell = _cells[index];
    if (cell.selected) {
        return;
    }
    [_cells setValue:@(NO) forKey:@"selected"];
    cell.selected = YES;
    _payWay = payway;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
