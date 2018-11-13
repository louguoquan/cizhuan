//
//  JJHomeSecoundCell.m
//  PXH
//
//  Created by louguoquan on 2018/9/4.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJHomeSecoundCell.h"


@interface JJHomeSecoundCell ()

@property (nonatomic,strong)UIView *baseView;

@end


@implementation JJHomeSecoundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


- (void)setDataArray:(NSMutableArray *)dataArray
{
    
    NSArray *imgarray = [dataArray firstObject];
    NSArray *titlearray = [dataArray lastObject];
    
    CGFloat w = kScreenWidth/3.0f;
    CGFloat h = w ;
    for (int i = 0; i<imgarray.count; i++) {
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(w*(i%3), h*(i/3), w, h)];
        view.tag = 1000+i;
        view.layer.borderWidth = 0.2;
        view.layer.borderColor = HEX_COLOR(@"#999999").CGColor;
//        view.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1.0];
        [self.baseView addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1.0];
        imageView.image = [UIImage imageNamed:imgarray[i]];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.width.height.mas_offset(60);
            make.top.equalTo(view).offset(20);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titlearray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = HEX_COLOR(@"#333333");
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.equalTo(imageView.mas_bottom).offset(5);
            make.height.mas_offset(15);
        }];
        
//        if (i=0) {
//            UILabel *label1 = [[UILabel alloc]init];
//            label1.text = @"(即将上线)";
//            label1.font = [UIFont systemFontOfSize:15];
//            label1.textColor = HEX_COLOR(@"#666666");
//            label1.textAlignment = NSTextAlignmentCenter;
//            [view addSubview:label1];
//            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(view);
//                make.top.equalTo(label.mas_bottom).offset(5);
//                make.height.mas_offset(15);
//                //            make.bottom.equalTo(view).offset(-10);
//            }];
//        }
        
    }
    
    [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(h*(imgarray.count%3==0?imgarray.count/3:imgarray.count/3+1));
    }];
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (self.HomeSecoundClick) {
        self.HomeSecoundClick(tap.view.tag - 1000);
    }
    
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
