//
//  JYSheetView.h
//  PXH
//
//  Created by LX on 2018/6/3.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPopupView.h"

typedef void(^SelectTypeBlock)(NSString *type, NSInteger idx);

@interface JYSheetView : JYPopupView

@property (nonatomic, strong) SelectTypeBlock   selBlock;

-(instancetype)initWithItemTitleArray:(NSArray *)titleArray selTypeBlock:(SelectTypeBlock)block;

@end
