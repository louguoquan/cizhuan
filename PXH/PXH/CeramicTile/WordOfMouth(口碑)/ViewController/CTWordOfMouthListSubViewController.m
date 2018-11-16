//
//  CTWordOfMouthListSubViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTWordOfMouthListSubViewController.h"
#import "CTProductDetailCommentCell.h"

@interface CTWordOfMouthListSubViewController ()

@end

@implementation CTWordOfMouthListSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.tableView.estimatedRowHeight = 100;
     [self.tableView registerClass:[CTProductDetailCommentCell class] forCellReuseIdentifier:@"CTProductDetailCommentCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTProductDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTProductDetailCommentCell"];
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
