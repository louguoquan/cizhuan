//
//  JYGatherAddManagerController.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYGatherAddManagerController.h"
#import "JYAddGatherAddressController.h"

#import "JYEmptyView.h"
#import "JYGatherAddCell.h"

#import "JYMineService.h"

@interface JYGatherAddManagerController ()

@property (nonatomic, strong) JYEmptyView *emptyView;

@property (nonatomic, strong) UIView      *footView;

@property (nonatomic, strong) NSArray<JYGatherAddModel *>       *addInfoArr;

@end

static NSString *const gatherAddCellID = @"JYGatherAddCell_ID";

@implementation JYGatherAddManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpTableView];
    [self.view bringSubviewToFront:self.footView];
    
    [self fetchProductList:NO];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"收款地址管理";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpTableView
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    self.tableView.estimatedRowHeight = 120.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    
    [self.tableView registerClass:JYGatherAddCell.class forCellReuseIdentifier:gatherAddCellID];
    
    WS(weakSelf)
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header beginRefreshing];
        [weakSelf fetchProductList:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductList:YES];
    }];
}

- (void)fetchProductList:(BOOL)loadMore
{
    [JYMineService getReceivableAddressListCompletion:^(id result, id error) {
        self.addInfoArr = [result mutableCopy];
        
        self.emptyView.hidden = (self.addInfoArr.count)?YES:NO;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setUpDefaultBankCard:(NSString *)cardId
{
    [MBProgressHUD showLoadingText:@"设置中..." toContainer:nil];
    [JYMineService setUpDefaultBankCardWithId:cardId completion:^(id result, id error) {
        [MBProgressHUD showText:@"设置默认成功" toContainer:nil];
        [self fetchProductList:NO];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addInfoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYGatherAddCell *cell = [tableView dequeueReusableCellWithIdentifier:gatherAddCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addModel = self.addInfoArr[indexPath.row];
    cell.setDefaultAddBlock = ^(UISwitch *dswitch, BOOL isDefault) {
        
        NSString *cardId = [self.addInfoArr[indexPath.row] ID];
        if (dswitch.isOn) {
            [self setUpDefaultBankCard:cardId];
        }else{
            NSLog(@"取消默认");
        }
    };
    
    return cell;
}

//MARK: -- 删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [JYMineService delReceivableAddressID:self.addInfoArr[indexPath.row].ID Completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
            [self.tableView.mj_header beginRefreshing];
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_c2cSelBankNumBlock) {//c2c
        JYGatherAddModel *model = self.addInfoArr[indexPath.row];
        _c2cSelBankNumBlock(model.cardNum, model.ID);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)addAddressAction
{
    NSLog(@"添加地址");
    JYAddGatherAddressController *gatherVC = [[JYAddGatherAddressController alloc] init];
    gatherVC.addSuccessBlock = ^{
      
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:gatherVC animated:YES];
}


- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
        [self.view addSubview:self.emptyView];
        
        [_emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];
    }
    [self.view insertSubview:_emptyView atIndex:1];
    
    return _emptyView;
}

- (UIView *)footView
{
    if (!_footView) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight- kStatusBarHeight-kNavigationBarHeight-70, kScreenWidth, 70.f)];
        [self.view addSubview:footView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 5, kScreenWidth-15*2, 47.f);
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn setTitle:@"添加地址" forState:0];
        [btn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btn];
        btn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
        
        _footView = footView;
    }
    return _footView;
}


@end
