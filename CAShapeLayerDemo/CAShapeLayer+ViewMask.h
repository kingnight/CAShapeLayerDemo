//
//  NSObject+ViewMask.h
//  CAShapeLayerDemo
//
//  Created by pioneer on 2016/9/25.
//  Copyright © 2016年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view;
+ (instancetype)createRoundMaskLayerWithView:(UIView *)view;
+ (instancetype)createRoundProgressbarWithView:(UIView *)view color:(UIColor *)color;
@end
