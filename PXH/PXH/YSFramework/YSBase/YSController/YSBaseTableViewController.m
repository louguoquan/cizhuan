
//
//  YSBaseTableViewController.m
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseTableViewController.h"

@interface YSBaseTableViewController ()

@end

@implementation YSBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setEmptyDesc:(NSString *)emptyDesc {
    
    _emptyDesc = [emptyDesc copy];
    
    [self.tableView reloadEmptyDataSet];
}

- (void)setEmptyImage:(UIImage *)emptyImage {
    _emptyImage = emptyImage;
    
    [self.tableView reloadEmptyDataSet];
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    
    _verticalOffset = verticalOffset;
    
    [self.tableView reloadEmptyDataSet];
}

- (void)emptyViewDidTap {
    
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (!_emptyDesc) {
        return nil;
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.f],
                                 NSForegroundColorAttributeName:HEX_COLOR(@"#999999")};
    
    return [[NSAttributedString alloc] initWithString:_emptyDesc attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return _emptyImage;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    return _verticalOffset;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    
    [self emptyViewDidTap];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
