//
//  JJShareQRCodeView.h
//  PXH
//
//  Created by louguoquan on 2018/10/29.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^JJShareQRCodeViewClick)(UIImage *image);

@interface JJShareQRCodeView : MMPopupView

@property (nonatomic,strong)JJShareQRCodeViewClick JJShareQRCodeViewClick;
- (instancetype)initWithProduct:(NSString *)product limitID:(NSString *)limitID;

@end
