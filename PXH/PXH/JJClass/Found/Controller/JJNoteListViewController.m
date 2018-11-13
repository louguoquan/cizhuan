//
//  JJNoteListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/10/9.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJNoteListViewController.h"
#import "JJNoteListCell.h"
#import "JYWebController.h"

@interface JJNoteListViewController ()

@property (nonatomic,strong)NSMutableArray *dataArrM;

@end

@implementation JJNoteListViewController

- (NSMutableArray *)dataArrM
{
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[JJNoteListCell class] forCellReuseIdentifier:@"JJNoteListCell"];
    
    [self setUpNavUI];
    [self query];
}

- (void)query{
    
    [JJFoundService JJMobileCmsNoticeCompletion:^(id result, id error) {
        self.dataArrM = result;
        if (self.dataArrM.count>0) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
}

- (void)setUpNavUI
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"公告活动";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJNoteListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJNoteListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArrM.count) {
        cell.model = self.dataArrM[indexPath.row];        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJHomeModel *model = self.dataArrM[indexPath.row];
    if (model.url.length>0) {
        JYWebController *vc = [[JYWebController alloc]init];
        vc.urlString = model.url;
        vc.navTitle = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
