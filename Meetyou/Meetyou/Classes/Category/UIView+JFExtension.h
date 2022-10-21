//
//  UIView+JFExtension.h
//  百思不得姐
//
//  Created by CHAMFENG on 2017/5/19.
//  Copyright © 2017年 CY17173. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JFExtension)

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

@end
