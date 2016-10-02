//
//  ViewController.m
//  CAShapeLayerDemo
//
//  Created by pioneer on 2016/9/25.
//  Copyright © 2016年 sohu. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"

#define TOTAL_NUM 100

@interface ViewController ()
@property (nonatomic ,strong) UIView *dynamicView;
@property (nonatomic ,strong) CAShapeLayer *indicateLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self layerMask];
    
    [self layerRoundMask];
    
    [self layerRoundProgressBar];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)layerMask{
    //View
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 50, 80, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:view];
    view.layer.mask = layer;
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(140, 50, 80, 100);
    CAShapeLayer *layer2 = [CAShapeLayer createMaskLayerWithView:imageView];
    imageView.layer.mask = layer2;
    
    [self.view addSubview:imageView];
    
    //原始大小（对比用）
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(240, 50, 80, 100)];
    view2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view2];
}

/**
 圆形
 */
- (void)layerRoundMask{
    //背景层半径
    CGFloat bgViewRadius = 5;
    //背景层
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(40-bgViewRadius, 200-bgViewRadius, 80+bgViewRadius*2, 150+bgViewRadius*2)];
    bgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bgView];
    CAShapeLayer *layer2 = [CAShapeLayer createRoundMaskLayerWithView:bgView];
    bgView.layer.mask = layer2;
    //内部动态更新层
    _dynamicView = [[UIView alloc]initWithFrame:CGRectMake(40, 200, 80, 150)];
    _dynamicView.backgroundColor = [UIColor redColor];
    _dynamicView.clipsToBounds = YES;
    [self.view addSubview:_dynamicView];
    CAShapeLayer *layer = [CAShapeLayer createRoundMaskLayerWithView:_dynamicView];
    _dynamicView.layer.mask = layer;
    //设置更新
    [self refreshUIWithVoicePower:20];
    
    
}

-(void)refreshUIWithVoicePower : (NSInteger)voicePower{
    CGFloat height = (voicePower)*(CGRectGetHeight(_dynamicView.frame)/TOTAL_NUM);
    if (_indicateLayer) {
        [_indicateLayer removeFromSuperlayer];
        _indicateLayer = nil;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_dynamicView.frame)-height, CGRectGetWidth(_dynamicView.frame), height) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = path.CGPath;
    _indicateLayer.fillColor = [UIColor whiteColor].CGColor;
    [_dynamicView.layer addSublayer:_indicateLayer];
}

- (IBAction)sliderRoundMask:(UISlider *)sender {
    [self refreshUIWithVoicePower:sender.value];
}


- (void)layerRoundProgressBar{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 400, 80, 80)];
    [self.view addSubview:view];
    
    NSUInteger radius = 10;
    UIView *viewsub = [[UIView alloc]initWithFrame:CGRectMake(40+radius, 400+radius, 80-2*radius, 80-2*radius)];
    [self.view addSubview:viewsub];
    
    
    [CAShapeLayer createRoundProgressbarWithView:view color:[UIColor redColor]];
    [CAShapeLayer createRoundProgressbarWithView:viewsub color:[UIColor greenColor]];
}
@end
