//
//  NSObject+ViewMask.m
//  CAShapeLayerDemo
//
//  Created by pioneer on 2016/9/25.
//  Copyright © 2016年 sohu. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"

@implementation CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

+ (instancetype)createRoundMaskLayerWithView:(UIView *)view{
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat radius = CGRectGetWidth(view.frame)/2;
    CGPoint center1 = CGPointMake(radius, radius);
    CGPoint center2 = CGPointMake(radius, viewHeight-radius);
    
    
    CGPoint point1 = CGPointMake(0, radius);
    CGPoint point3 = CGPointMake(viewWidth, viewHeight-radius);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:point1];
    [path addArcWithCenter:center1
                    radius:radius
                startAngle:M_PI
                  endAngle:0
                 clockwise:YES];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2
                    radius:radius
                startAngle:0
                  endAngle:M_PI
                 clockwise:YES];
    [path addLineToPoint:point1];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

+ (instancetype)createRoundProgressbarWithView:(UIView *)view color:(UIColor *)color{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = view.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = color.CGColor;
    
    [view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    return shapeLayer;
}

@end
