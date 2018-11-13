//
//  JYSignInController.h
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSBaseScrollViewController.h"



@interface JYSignInController : YSBaseScrollViewController

/// item索引
@property (nonatomic,strong)NSString *index;

/// 区分注册、忘记密码
@property (nonatomic,strong)NSString *pushType;

@end
