//
//  YSSetupTableViewCell.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSSetupTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *leftImageView;

@property (nonatomic, strong) UILabel       *titleLabel;

@property (nonatomic, strong) UILabel       *descLabel;

@property (nonatomic, strong) UIImageView   *rightImageView;

- (void)setLeftImage:(UIImage *)leftImage title:(NSString *)title content:(NSString *)content rightImage:(id)rightImage;

@end
