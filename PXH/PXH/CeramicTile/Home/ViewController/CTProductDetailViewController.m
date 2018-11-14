//
//  CTProductDetailViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductDetailViewController.h"
#import "CTProductDetailSpecialCell.h"
#import "CTProductDetailCommentCell.h"
#import "SDCycleScrollView.h"
#import "CTProductDetailBottomView.h"

#import "CTParamterViewController.h"

@interface CTProductDetailViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *pricelLabel;

@property (nonatomic,strong)UIView *parameterView;


@end

@implementation CTProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"产品详情";
    
    [self setUI];
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTProductDetailSpecialCell class] forCellReuseIdentifier:@"CTProductDetailSpecialCell"];
    [self.tableView registerClass:[CTProductDetailCommentCell class] forCellReuseIdentifier:@"CTProductDetailCommentCell"];
}

- (void)setUI{
    
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,300)];
    
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
    //    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [head addSubview:_cycleScrollView];
    
    _parameterView = [[UIView alloc]init];
    [head addSubview:_parameterView];
    [_parameterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(head).offset(-15);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
        make.top.equalTo(_cycleScrollView.mas_bottom).offset(15);
    }];
    
    _parameterView.backgroundColor = [UIColor redColor];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.backgroundColor = [UIColor greenColor];
    [_parameterView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.parameterView);
        make.top.equalTo(self.parameterView);
        make.width.height.mas_offset(40);
    }];
    
    
    UILabel * ag1 = [[UILabel alloc]init];
    ag1.font = [UIFont systemFontOfSize:12];
    ag1.textColor = HEX_COLOR(@"#555555");
    ag1.text = @"参数配置";
    ag1.textAlignment = NSTextAlignmentCenter;
    [_parameterView addSubview:ag1];
    [ag1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom);
        make.left.right.equalTo(self.parameterView);
        make.height.mas_offset(20);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoParam:)];
    _parameterView.userInteractionEnabled = YES;
    [_parameterView addGestureRecognizer:tap];
    
    
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = HEX_COLOR(@"#333333");
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [head addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleScrollView.mas_bottom).offset(10);
        make.left.equalTo(head).offset(15);
        make.right.equalTo(self.parameterView.mas_left).offset(-15);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    _pricelLabel = [[UILabel alloc]init];
    _pricelLabel.textColor = HEX_COLOR(@"#777777");
    _pricelLabel.font = [UIFont systemFontOfSize:12];
    [head addSubview:_pricelLabel];
    [_pricelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(head).offset(15);
        make.height.greaterThanOrEqualTo(@15);
    }];
    
    
    
    _titleLabel.text = @"马可釉面瓷砖LF5986";
    
    _pricelLabel.text = [NSString stringWithFormat:@"指导价:%@",@"￥13.0-14.0"];
    
    
    self.tableView.tableHeaderView = head;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    
    CTProductDetailBottomView *bottom = [[CTProductDetailBottomView alloc]init];
    bottom.layer.borderColor = HEX_COLOR(@"#E7E7E7").CGColor;
    bottom.layer.borderWidth = 0.5;
//    bottom.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.mas_offset(60);
        make.left.right.equalTo(self.view);
    }];
    
}

- (void)gotoParam:(UITapGestureRecognizer *)tap{
    
    CTParamterViewController *vc = [[CTParamterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        CTProductDetailSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTProductDetailSpecialCell"];
        return cell;
    }
    CTProductDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTProductDetailCommentCell"];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    head.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = HEX_COLOR(@"#333333");
    [head addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head).offset(15);
        make.height.mas_offset(20);
        make.top.equalTo(head).offset(10);
    }];
    
    
    if (section == 0) {
        titleLabel.text = @"规格";
        
        [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(head);
        }];
    }else{
        titleLabel.text = @"评价";
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = HEX_COLOR(@"#F9F4F8");
        label.textColor = HEX_COLOR(@"#555555");
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"共25条评论";
        [head addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(titleLabel);
            make.height.mas_offset(30);
            make.right.equalTo(head).offset(-15);
        }];
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = YES;
        
        CGRect frame = head.frame;
        frame.size.height = frame.size.height+40;
        head.frame = frame;
        
    
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#B5B5B5");
    [head addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(head);
        make.height.mas_offset(0.5);
        make.left.right.equalTo(head);
    }];
    
    
    return head;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 80;
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
