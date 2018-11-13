//
//  JJCalculateTaskViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateTaskViewController.h"
#import "JJCalculateTaskCell.h"
#import "JYWebController.h"
#import "PTLAlertView.h"



@interface JJCalculateTaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UILabel *counLabel;

@property (nonatomic,strong)UIView *lastView;

@property (nonatomic,strong)NSString *url;

@property (nonatomic,strong)UICollectionView* collectionView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation JJCalculateTaskViewController


- (void)viewWillAppear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    
    [self setUpNav];
    [self setUI];
    
}

- (void)setUI{
    
    
    
    UIView *head = [[UIView alloc]init];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.containerView addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
    }];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"当前算力";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [head addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(head);
        make.top.equalTo(head).offset(15);
        make.height.mas_offset(15);
    }];
    
    [head addSubview:self.counLabel];
    [self.counLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(head);
        make.top.equalTo(label.mas_bottom).offset(15);
        make.height.mas_offset(28);
        make.bottom.equalTo(head).offset(-30);
    }];
    
    
    UIView *TaskView = [[UIView alloc]init];
    [self.containerView addSubview:TaskView];
    [TaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(head.mas_bottom);
        make.height.mas_offset(60);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"任务";
    label1.font = [UIFont systemFontOfSize:17];
    label1.textColor = HEX_COLOR(@"333333");
    [TaskView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TaskView).offset(10);
        make.top.equalTo(TaskView).offset(10);
        make.width.mas_offset(100);
        make.bottom.equalTo(TaskView).offset(-10);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"完成任务获得更多算力";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = HEX_COLOR(@"999999");
    [TaskView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(10);
        make.right.equalTo(TaskView).offset(-10);
        make.top.equalTo(TaskView).offset(10);
        make.bottom.equalTo(TaskView).offset(-10);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#ECECEC");
    [TaskView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(TaskView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(TaskView);
    }];
    
    
    [self.containerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(TaskView.mas_bottom);
        make.height.mas_offset((kScreenWidth-40)/3.0*2.5);
    }];

    
  
  
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"算力越多，获取的MACH就越多";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = HEX_COLOR(@"999999");
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.collectionView.mas_bottom).offset(20);
        make.height.mas_offset(20);
        make.bottom.equalTo(self.containerView);
    }];

   [self query];
    
//    self.counLabel.text = @"100";
    
}

- (void)query{
    
    [JJCalculateService myCountCompletion:^(id result, id error) {
        self.counLabel.text = [NSString stringWithFormat:@"%@",result[@"result"]];
    }];
    
    
    [JJCalculateService JJSecretBooksCompletion:^(id result, id error) {
        self.url = result[@"result"];
    }];
    
    
    [JJCalculateService JJSafetyTaskCompletion:^(id result, id error) {
        
        self.dataArray = result;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat height = (((kScreenWidth-40)/3.0+5)*1.4)*(self.dataArray.count%3 == 0?(self.dataArray.count/3):(self.dataArray.count/3+1));
            make.height.mas_offset(height);
        }];
        [self.collectionView reloadData];
        
    }];
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"算力任务";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"算力秘籍" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    
    JYWebController *vc = [[JYWebController alloc]init];
    vc.urlString = self.url;
    vc.navTitle = @"算力秘籍";
    [self.navigationController pushViewController:vc animated:YES];
    
}




#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return 6;
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJCalculateTaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JJCalculateTaskCell" forIndexPath:indexPath];
    if (self.dataArray.count) {
        JJTaskModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
    
    
//    //孔红亚
//    13958091107
//
//    23楼
//    三宏国际
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     JJTaskModel *model = self.dataArray[indexPath.row];
    
    [JJCalculateService JJIntroduction:model.ID Completion:^(id result, id error) {
        
        NSString* messageStr = result[@"result"];
        if (messageStr.length>0) {
            PTLAlertView *alertView = [[PTLAlertView alloc]initWithTitle:model.title message:messageStr cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            
            [alertView setSelctBtnBlock:^(NSInteger index, NSString * _Nullable btnCurrentTitle) {
                NSLog(@"hha- %zd ---- %@", index, btnCurrentTitle);
            }];
            
            alertView.cancelBtnTextColor = [UIColor redColor];
            [alertView show];
        }
    }];
    
   
    
}


/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (kScreenWidth-40)/3.0-5;
    return CGSizeMake(itemW, itemW*1.4);
}
/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}





- (UILabel *)counLabel
{
    if (!_counLabel) {
        _counLabel = [[UILabel alloc]init];
        _counLabel.textColor = GoldColor;
        _counLabel.textAlignment = NSTextAlignmentCenter;
        _counLabel.font = [UIFont systemFontOfSize:30];
    }
    return _counLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        /**
         创建layout
         */
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        /**
         创建collectionView
         */
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[JJCalculateTaskCell class] forCellWithReuseIdentifier:@"JJCalculateTaskCell"];
        
     

    }
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
