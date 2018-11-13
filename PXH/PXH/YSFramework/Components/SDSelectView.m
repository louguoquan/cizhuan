//
//  SDSelectView.m
//  SundayFramework
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "SDSelectView.h"

@interface SDSelectView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation SDSelectView

- (instancetype)initWithTitle:(NSString *)title array:(NSArray *)array handler:(SDSelectHandler)selectHandler {
    self = [super init];
    
    if (self) {
        self.dataArray = [array copy];
        
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        
        self.type = MMPopupTypeAlert;
        
        self.layer.cornerRadius = 2.0;
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat height = array.count > 8 ? 44 * 8 : array.count * 44 + (title.length > 0 ? 40 : 0);
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 10;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        
        if (title.length > 0) {
            UILabel *titleLabel = [UILabel new];
            titleLabel.textColor = HEX_COLOR(@"#333333");
            titleLabel.font = [UIFont systemFontOfSize:16.0];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(self);
                make.height.equalTo(@40);
            }];
        }
        
        self.tableView = [UITableView new];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorColor = LINE_COLOR;
        self.selectHandler = selectHandler;
        if (array.count <= 8) {
            self.tableView.scrollEnabled = NO;
        }
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(title.length > 0 ? 40 : 0, 0, 0, 0));
        }];
    }
    
    return self;
}

#pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *identifier = @"selectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = HEX_COLOR(@"#666666");
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

#pragma UIPickerViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectHandler) {
        self.selectHandler(indexPath.row);
    }
    [self hide];
}

@end
