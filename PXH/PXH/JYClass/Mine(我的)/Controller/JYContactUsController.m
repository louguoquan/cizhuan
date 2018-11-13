//
//  JYContactUsController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYContactUsController.h"

#import "JYWebController.h"

#import "JYMineService.h"
#import "JYCmsIndexModel.h"
#import "JYCmsContentModel.h"


//weixin、mqq、sinaweibo
#define SCHEMS_URL(obj) [NSURL URLWithString:[NSString stringWithFormat:@"%@://", obj]]

#define IS_INSTALL(obj) [[UIApplication sharedApplication] canOpenURL:SCHEMS_URL(obj)]


@interface JYContactUsController (){
    
//    NSArray  *_titleArr;
//    NSArray *_detailArr;
    
    NSInteger       page;
}

@property (nonatomic, strong) NSArray   *listArr;

@end

@implementation JYContactUsController

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
    navigationLabel.text = @"联系我们";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{
//    _titleArr = @[@"官方QQ群", @"关注微信", @"邮箱客服", @"官网微博", @"商务合作", @"Telegram", @"Facebook", @"Twitter"];
//    _detailArr = @[@"898562362", @"微信名", @"邮箱地址", @"微博名", @"网址"];
    
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

//    if (indexPath.row<_detailArr.count) {
//        cell.detailTextLabel.text = _detailArr[indexPath.row];
//    }
//
//    cell.textLabel.text = _titleArr[indexPath.row];
    
    JYCmsIndexModel *model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    cell.textLabel.text = model.title;
    if (model.desc && model.desc.length) {
        cell.detailTextLabel.text = model.desc;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYCmsIndexModel *model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    
    if (model.ID.integerValue>=17 && model.ID.integerValue<=20) {
        [self SWIfInstallWithId:model.ID.integerValue indexPath:indexPath];
    }
    else {
        [self pushWebWithUrl:model.url withNavTitle:model.title];
    }
}

- (void)SWIfInstallWithId:(NSInteger)Id indexPath:(NSIndexPath *)indexPath
{
    NSString *schemes = @"mqq";
    switch (Id) {
        case 18: schemes = @"weixin"; break;
        case 19: schemes = @"mailto"; break;//邮箱
        case 20: schemes = @"sinaweibo"; break;//指定页面：sinaweibo://userinfo?uid=你的uid”
    }
    
    //复制
    JYCmsIndexModel *model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    pBoard.string = model.desc;
    
    if (IS_INSTALL(schemes)) {
        NSURL *url = SCHEMS_URL(schemes);
        if (Id==19) url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", schemes, model.desc]];
//        if (Id==20) url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://userinfo?uid=%@", schemes, @"指定页面uid"]];//微博指定页面
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        if (Id==20) {
//            NSString *url = @"";
            [self pushWebWithUrl:model.url withNavTitle:model.title];
        }
        else {
             [MBProgressHUD showText:@"复制成功" toContainer:nil];
        }
    }
}



- (void)getListInfo:(BOOL)isMore
{
    WS(weakSelf)
    [JYMineService cmsIndexListWithId:@"3" page:page completion:^(id result, id error) {
        
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
            [self pushWebWithUrl:model.url withNavTitle:model.title];
        }else{
            [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
        }
    }];
}

- (void)pushWebWithUrl:(NSString *)url withNavTitle:(NSString *)title
{
    if (url && url.length) {
        JYWebController *vc = [[JYWebController alloc] init];
        vc.urlString = url;
        vc.navTitle = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
    }
}

@end
