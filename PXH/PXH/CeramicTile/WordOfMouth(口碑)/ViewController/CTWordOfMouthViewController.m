//
//  CTWordOfMouthViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTWordOfMouthViewController.h"
#import "CTWordOfMouthCell.h"
#import "CTWordOfMouthHeadView.h"

@interface CTWordOfMouthViewController ()

@end

@implementation CTWordOfMouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CTWordOfMouthHeadView *head = [[CTWordOfMouthHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    self.tableView.tableHeaderView = head;
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTWordOfMouthCell class] forCellReuseIdentifier:@"CTWordOfMouthCell"];
    NSLog(@"1212");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTWordOfMouthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTWordOfMouthCell"];
    return cell;
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
