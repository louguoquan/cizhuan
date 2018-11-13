//
//  YSRecommendViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRecommendViewController.h"
#import "YSRecommendTableViewCell.h"
//#import <UMSocialCore/UMSocialCore.h>
#import "YSPagingListService.h"

#import "SDShareView.h"

@interface YSRecommendViewController ()
{
    BOOL state;
}
@property (nonatomic, strong) SDShareView *share;
@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的推荐";
    
    state = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self setup];
    [self fetchFansWithLoadMore:NO];
}

- (void)setup {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSAccountService class] action:@selector(fetchFansList:page:completion:)];
    self.tableView.rowHeight = 65.f;
    [self.tableView registerClass:[YSRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchFansWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchFansWithLoadMore:YES];
    }];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)fetchFansWithLoadMore:(BOOL)loadMore {
    
    [_service loadDataWithParameters:nil isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)shareAction {
    
    if (state == YES) {
        if (!_share) {
            WS(weakSelf);
            self.share = [SDShareView new];
            self.share.selectPlatForm = ^(NSInteger plat) {
                [weakSelf loadThird:plat];
            };
            self.share.cancel = ^{
                weakSelf.share.hidden = YES;
                state = YES;
            };
            [self.view addSubview:self.share];
            
            [_share mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.offset(0);
            }];
        }
        state = NO;
        _share.hidden = NO;
    } else {
        _share.hidden = YES;
        state = YES;
    }
}

- (void)loadThird:(NSInteger)platFormType
{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    //创建网页内容对象
//    NSString* thumbURL = nil;
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"品行惠邀请注册" descr:@"你的好友赠送你优惠券，邀请你成为品行惠APP用户" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = [NSString stringWithFormat:@"http://mobile.zjpxny.com/mobile/member/getShareHtml?memberId=%@", [YSAccount sharedAccount].ID];
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    [[UMSocialManager defaultManager] shareToPlatform:platFormType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        NSString *message= nil;
//        if (!error) {
//            message  = @"分享成功";
//            [MBProgressHUD showSuccessMessage:message toContainer:nil];
//        } else {
//            if ((NSInteger) error.code == 2010) {
//                message = @"用户取消分享";
//            } else {
//                message = @"分享失败";
//            }
//        }
//        [MBProgressHUD showErrorMessage:message toContainer:nil];
//    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.fans = _service.dataSource[indexPath.row];
    return cell;
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
