//
//  JYContactSynopsisController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYContactSynopsisController.h"

#import "JYAssetsService.h"

@interface JYContactSynopsisController ()
{
    NSArray     *_titleArr;
    NSArray     *_infoArr;
}

@property (nonatomic, strong) UILabel       *headNameLab;
@property (nonatomic, strong) UILabel       *brieContentLab;

@property (nonatomic, strong) UIView        *lastView;

@end

static NSInteger  Base_Tag = 100;

@implementation JYContactSynopsisController

- (UILabel *)headNameLab
{
    if (!_headNameLab) {
        _headNameLab = [[UILabel alloc] init];
        _headNameLab.font = [UIFont systemFontOfSize:17];
        _headNameLab.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    }
    return _headNameLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"发行时间", @"发行总量", @"流通总量", @"众筹价格", @"白皮书", @"官网", @"区块查询"];
    
    [self setUpNav];
    [self setUpUI];

    [self getCoinInfo];
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = self.cuntactName;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpUI
{
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    
    UIView *bgView = [[UIView alloc] init];
    [self.scrollView addSubview:bgView];
    
    [bgView addSubview:self.headNameLab];
    WS(weakSelf);
    [self.headNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).mas_offset(15.f);
        make.left.mas_equalTo(15.f);
    }];
    
    for (int i=0; i<_titleArr.count; i++) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.font = [UIFont systemFontOfSize:15];
        titleLab.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        titleLab.text = _titleArr[i];
        
        UILabel *infoLab = [[UILabel alloc] init];
        infoLab.textAlignment = NSTextAlignmentRight;
        infoLab.font = [UIFont systemFontOfSize:15];
        infoLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        infoLab.tag = Base_Tag + i;
        
        [bgView addSubview:titleLab];
        [bgView addSubview:infoLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (weakSelf.lastView) {
                make.top.equalTo(weakSelf.lastView.mas_bottom).mas_offset(10.f);
            }
            else {
                make.top.equalTo(weakSelf.headNameLab.mas_bottom).mas_offset(20.f);
            }
            make.left.mas_equalTo(15.f);
        }];
        
        [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLab);
            make.right.mas_equalTo(-15.f);
            make.left.equalTo(titleLab.mas_right).mas_offset(30);
        }];
        
        _lastView = titleLab;
    }
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.dk_backgroundColorPicker = DKColorPickerWithKey(LINE);
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lastView.mas_bottom).mas_offset(20.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(1.f);
    }];
    _lastView = lineView;
    
    //简介
    UILabel *brieTitleLab = [[UILabel alloc] init];
    brieTitleLab.textAlignment = NSTextAlignmentLeft;
    brieTitleLab.font = [UIFont systemFontOfSize:15];
    brieTitleLab.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    brieTitleLab.text = @"简介";
    [bgView addSubview:brieTitleLab];
    [brieTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lastView.mas_bottom).mas_offset(20.f);
        make.left.mas_equalTo(15.f);
    }];
    _lastView = brieTitleLab;
    
    //简介内容
    _brieContentLab = [[UILabel alloc] init];
    _brieContentLab.numberOfLines = 0;
    _brieContentLab.textAlignment = NSTextAlignmentLeft;
    _brieContentLab.font = [UIFont systemFontOfSize:14.f];
    _brieContentLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    [bgView addSubview:_brieContentLab];
    [_brieContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lastView.mas_bottom).mas_offset(10.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
    }];
    _lastView = _brieContentLab;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.scrollView);
        make.bottom.equalTo(weakSelf.lastView).mas_offset(20.f);
    }];
    _lastView = bgView;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lastView);
    }];
}


//获取币种信息
- (void)getCoinInfo
{
    [MBProgressHUD showLoadingToContainer:nil];
    
    [JYAssetsService getCoinById:self.coinId completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        
        JYCoinInfoModel *model = (JYCoinInfoModel *)result;
        
        self.headNameLab.text = [NSString stringWithFormat:@"%@(%@)", model.code, model.name];
        [self setUplineSpacing:7.f withContent:model.simpleDesc withSetObject:self.brieContentLab];
        
        for (int i=0; i<_titleArr.count; i++) {
            
            UILabel *lab = (UILabel *)[self.view viewWithTag:Base_Tag+i];
            switch (i) {
                case 0:lab.text = [self isNull:model.publishTime]; break;
                case 1:lab.text = [NSString stringWithFormat:@"%@万", [self isNull:model.publishSummary]]; break;
                case 2:lab.text = [NSString stringWithFormat:@"%@万", [self isNull:model.totalCirculation]]; break;
                case 3:lab.text = [NSString stringWithFormat:@"$%@", [self isNull:model.crowdfundingPrice]]; break;
                case 4:lab.text = [self isNull:model.whitePaper]; break;
                case 5:lab.text = [self isNull:model.officialWebsite]; break;
                case 6:lab.text = [self isNull:model.blockQuery]; break;
            }
        }
    }];
}

//行间距
- (void)setUplineSpacing:(NSInteger)spacing withContent:(NSString *)content withSetObject:(UILabel *)lab
{
    if (!content) return;
    
    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [paragraphStyle setLineBreakMode:lab.lineBreakMode];
    [paragraphStyle setAlignment:lab.textAlignment];
    [muArrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    lab.attributedText = muArrStr;
}


- (NSString *)isNull:(NSString *)string
{
    if (!string || string.length==0 || [string isEqualToString:@"0"]) {
        return @"-";
    }
    
    return string;
}

- (void)setCuntactName:(NSString *)cuntactName
{
    _cuntactName = cuntactName;
}

-(void)setCoinId:(NSString *)coinId
{
    _coinId = coinId;
}


@end
