//
//  JYGatherAddCell.h
//  PXH
//
//  Created by LX on 2018/6/13.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYGatherAddModel.h"


@interface JYGatherAddCell : UITableViewCell

@property (nonatomic, strong) JYGatherAddModel      *addModel;

@property (nonatomic, copy) void(^setDefaultAddBlock)(UISwitch *dswitch, BOOL isDefault);

@end
