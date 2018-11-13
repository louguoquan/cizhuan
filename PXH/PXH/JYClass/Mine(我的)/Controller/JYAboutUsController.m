//
//  JYAboutUsController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAboutUsController.h"
#import "JYWebController.h"

#import "JYMineService.h"
#import "JYCmsIndexModel.h"
#import "JYCmsContentModel.h"

@interface JYAboutUsController ()
{
    NSInteger       page;
}

@property (nonatomic, strong) NSArray   *listArr;

@end

@implementation JYAboutUsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    page = 0;
    
    [self getListInfo:NO];
    
    [self setUpNav];
    [self setupTableView];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"关于我们";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{
//    _listArr = @[@"官网", @"平台简介", @"用户协议", @"更新日志", @"检查新版本"];
    
    self.tableView.estimatedRowHeight = 51.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_header beginRefreshing];
        
        [self getListInfo:NO];
    }];
    
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        page++;
    //        [self.tableView.mj_footer beginRefreshing];
    //        [self getListInfo:YES];
    //    }];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13.f]];
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(CELLDETAILTEXT);
    
    cell.textLabel.text = [(JYCmsIndexModel*)self.listArr[indexPath.row] title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYCmsIndexModel *model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    if (model.url && model.url.length) {
        JYWebController *vc = [[JYWebController alloc] init];
        vc.urlString = model.url;
        vc.navTitle  = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
    }
}


- (void)getListInfo:(BOOL)isMore
{
    WS(weakSelf)
    [JYMineService cmsIndexListWithId:@"6" page:page completion:^(id result, id error) {
        
        if (isMore) {
            if (![(NSArray *)result count]) {
                self.tableView.mj_footer.hidden = YES;
                return;
            }
            NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.listArr];
            [muArr addObjectsFromArray:result];
            self.listArr = [muArr mutableCopy];
        }else{
            weakSelf.listArr = result;
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

- (void)getListItemContent:(NSString *)Id
{
    [MBProgressHUD showLoadingToContainer:nil];
    [JYMineService cmsContentWithId:Id completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        
        JYCmsContentModel *model = (JYCmsContentModel *)result;
        if (model.url.length) {
            JYWebController *vc = [[JYWebController alloc] init];
            vc.urlString = model.url;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
        }
    }];
}

@end
