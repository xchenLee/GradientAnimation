//
//  ViewController.m
//  animationGradient
//
//  Created by danlan on 2018/7/11.
//  Copyright © 2018 animation. All rights reserved.
//

#import "ViewController.h"

#define HEX_COLOR_ALPHA(_HEX_,a) [UIColor colorWithRed:((float)((_HEX_ & 0xFF0000) >> 16))/255.0 green:((float)((_HEX_ & 0xFF00) >> 8))/255.0 blue:((float)(_HEX_ & 0xFF))/255.0 alpha:a]

@interface ViewController ()

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, strong) UIView *viewOne;
@property (nonatomic, strong) UIView *viewTwo;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testView = [UIView new];
    self.testView.frame = CGRectMake(20, 200, 200, 40);
    
    self.viewOne = [UIView new];
    self.viewOne.frame = CGRectMake(0, 0, 200, 40);
    
    self.viewTwo = [UIView new];
    self.viewTwo.frame = CGRectMake(-200, 0, 200, 40);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HEX_COLOR_ALPHA(0x823AF1, 1).CGColor,
                             (__bridge id)HEX_COLOR_ALPHA(0xD5A7FF, 1).CGColor,
                             (__bridge id)HEX_COLOR_ALPHA(0x823AF1, 1).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.viewOne.bounds;
    [self.viewOne.layer addSublayer:gradientLayer];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[(__bridge id)HEX_COLOR_ALPHA(0x823AF1, 1).CGColor,
                              (__bridge id)HEX_COLOR_ALPHA(0xD5A7FF, 1).CGColor,
                              (__bridge id)HEX_COLOR_ALPHA(0x823AF1, 1).CGColor];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1.0, 0);
    gradientLayer1.frame = self.viewOne.bounds;
    [self.viewTwo.layer addSublayer:gradientLayer1];
    
    [self.testView addSubview:self.viewOne];
    [self.testView addSubview:self.viewTwo];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.testView.bounds cornerRadius:20];
    path1.lineWidth = 2;

    CGRect rect = CGRectMake(3, 3, 200 - 3 * 2, 34);
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:17];
    [path1 appendPath:path2];
    [path1 setUsesEvenOddFillRule:YES];

    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.path = path1.CGPath;
    shape.fillRule = kCAFillRuleEvenOdd;
    self.testView.layer.mask = shape;
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.testView];
    
    [self doRepeatAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)doRepeatAnimation {
    
    UIView *one = self.currentIndex == 0 ? self.viewOne : self.viewTwo;
    UIView *two = self.currentIndex == 0 ? self.viewTwo : self.viewOne;

    [UIView animateWithDuration:1 animations:^{
        one.frame = CGRectMake(200, 0, 200, 40);
        two.frame = CGRectMake(0, 0, 200, 40);
    } completion:^(BOOL finished) {
        one.frame = CGRectMake(-200, 0, 200, 40);
        self.currentIndex = 1 - self.currentIndex;
        [self doRepeatAnimation];
    }];
}

@end
