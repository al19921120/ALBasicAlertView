//
//  ALDetailAlertView.m
//  MYShengYiJia
//
//  Created by hwt on 16/10/13.
//  Copyright © 2016年 MYun. All rights reserved.
//

#import "ALDetailAlertView.h"

#define __kPopInTime 0.5

#define __kBorderSep 5
#define __kCornerLength 5
#define __kTriangleShortSideLength 10
#define __kTriangleFactor 1.4

#define __kSelfWidth self.frame.size.width
#define __kSelfHeight self.frame.size.height

@implementation ALDetailAlertView {
    CGFloat _xlineLength;
    CGFloat _ylineLength;
    CAShapeLayer *_maskBorderLayer;
    UIView *_subView;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame subView:(UIView *)view {
    
    if (self = [super initWithFrame:frame]) {
        
        CGRect rect = CGRectMake(0, 0, __kSelfWidth, __kSelfHeight);
        
        self.backgroundColor = [UIColor whiteColor];
        view.frame = rect;
        [self addSubview:view];
        _subView = view;
    }
    return self;
    
}

#pragma mark - public

- (void)popInFrom:(CGPoint)point orientation:(ALDetailAlertOrientation)orientation {
    
    [self addMaskWithOrientation:orientation];

    CABasicAnimation *animeFadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animeFadeIn.duration = __kPopInTime;
    animeFadeIn.fromValue = @0;
    animeFadeIn.toValue = @1;
    [self.layer addAnimation:animeFadeIn forKey:@"animFadeIn"];
    
    [self.layer addAnimation:[self animationPopInFromPoint:point orientation:orientation] forKey:@"animPopIn"];

    self.layer.opacity = 1;
    
}

- (void)popOut:(void(^)())completion {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeMask];
        if (completion) {
            completion();
        }
    }];
}

- (CAAnimationGroup *)animationPopInFromPoint:(CGPoint)point orientation:(ALDetailAlertOrientation)orientation{
    
    CAKeyframeAnimation *animeScale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animeScale.duration = __kPopInTime;
    animeScale.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DIdentity]
                          ];
    animeScale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animeScale.keyTimes = @[@0, @0.7, @0.8, @1];
//    animeScale.fillMode=kCAFillModeForwards;
    
    CGFloat xOffset = 0;
    CGFloat yOffset = 0;
    switch (orientation) {
        case ALDetailAlertOrientationUp:
            yOffset = __kSelfHeight/3;
            break;
        case ALDetailAlertOrientationDown:
            yOffset = -__kSelfHeight/3;;
            break;
        case ALDetailAlertOrientationLeft:
            xOffset = -__kSelfWidth/3;;
            break;
        case ALDetailAlertOrientationRight:
            xOffset = __kSelfWidth/3;;
            break;
            
        default:
            break;
    }
    
    CAKeyframeAnimation *animeOffset = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animeOffset.duration = __kPopInTime * 0.8;
    animeOffset.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
//                          [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + 20)],
//                          [NSValue valueWithCGPoint:CGPointMake(point.x, point.y + 50)],
                           [NSValue valueWithCGPoint:CGPointMake(point.x + xOffset, point.y + yOffset)]
                          ];
    animeOffset.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animeOffset.keyTimes = @[@0, @1];
//    animeOffset.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *animeGroup = [CAAnimationGroup animation];
    animeGroup.animations = @[animeScale ,animeOffset];
    animeGroup.duration = __kPopInTime;
//    animeGroup.fillMode=kCAFillModeForwards;
//    animeGroup.removedOnCompletion = NO;
    
    self.frame = CGRectMake(point.x + xOffset - __kSelfWidth/2, point.y + yOffset - __kSelfHeight/2, __kSelfWidth, __kSelfHeight);
    [self reviseSubView:orientation];
    return animeGroup;
}

#pragma mark - private

- (void)addMaskWithOrientation:(ALDetailAlertOrientation)orientation {
    
    //边框蒙版
    _maskBorderLayer = [CAShapeLayer layer];
    _maskBorderLayer.fillColor = [[UIColor clearColor] CGColor];
    _maskBorderLayer.strokeColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1].CGColor;
    _maskBorderLayer.lineWidth = 1;

    CGRect subViewRect;
    switch (orientation) {
        case ALDetailAlertOrientationUp:
            _xlineLength = __kSelfWidth - __kCornerLength*2 - __kTriangleShortSideLength*__kTriangleFactor;
            _ylineLength = __kSelfHeight- __kCornerLength*2;
            subViewRect = CGRectMake(self.frame.origin.x, __kBorderSep, __kSelfWidth, __kSelfHeight);
            [self upPath];
            break;
            
        case ALDetailAlertOrientationDown:
            _xlineLength = __kSelfWidth - __kCornerLength*2 - __kTriangleShortSideLength*__kTriangleFactor;
            _ylineLength = __kSelfHeight - __kCornerLength*2;
            subViewRect = CGRectMake(self.frame.origin.x, 0, __kSelfWidth, __kSelfHeight);
            [self downPath];
            break;

        case ALDetailAlertOrientationLeft:
            _xlineLength = __kSelfWidth - __kCornerLength*2;
            _ylineLength = __kSelfHeight - __kCornerLength*2 - __kTriangleShortSideLength*__kTriangleFactor;
            subViewRect = CGRectMake(__kBorderSep, 0, __kSelfWidth, __kSelfHeight);
//            bezierPath
            break;
            
        case ALDetailAlertOrientationRight:
            _xlineLength = __kSelfWidth - __kCornerLength*2;
            _ylineLength = __kSelfHeight - __kCornerLength*2 - __kTriangleShortSideLength*__kTriangleFactor;
            subViewRect = CGRectMake(0, 0, __kSelfWidth, __kSelfHeight);
//            bezierPath
            
            break;
            
        default:
            break;
    }

    [self.layer addSublayer:_maskBorderLayer];
    
}

- (void)removeMask {
    [_maskBorderLayer removeFromSuperlayer];
    _maskBorderLayer = nil;
    
}

- (void)reviseSubView:(ALDetailAlertOrientation)orientation {
    
    CGRect subViewRect;
    switch (orientation) {
        case ALDetailAlertOrientationUp:
            subViewRect = CGRectMake(0, __kBorderSep, __kSelfWidth, __kSelfHeight);
            break;
            
        case ALDetailAlertOrientationDown:
            subViewRect = CGRectMake(0, 0, __kSelfWidth, __kSelfHeight);
            break;
            
        case ALDetailAlertOrientationLeft:
            subViewRect = CGRectMake(__kBorderSep, 0, __kSelfWidth, __kSelfHeight);
            break;
            
        case ALDetailAlertOrientationRight:
            subViewRect = CGRectMake(0, 0, __kSelfWidth, __kSelfHeight);
            
            break;
            
        default:
            break;
    }
    
    _subView.frame = subViewRect;
}

#pragma mark - animate

#pragma mark - 

- (void)upPath {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(__kCornerLength ,__kCornerLength + __kBorderSep) radius:__kCornerLength startAngle:M_PI endAngle:1.5 * M_PI clockwise:YES];
    CGPoint point = CGPointMake(_xlineLength/2 + __kCornerLength, __kBorderSep);
    [bezierPath addLineToPoint:point];
    point = CGPointMake(point.x + __kTriangleShortSideLength*__kTriangleFactor/2, 0);
    [bezierPath addLineToPoint:point];
    point = CGPointMake(point.x + __kTriangleShortSideLength*__kTriangleFactor/2, __kBorderSep);
    [bezierPath addLineToPoint:point];
    point = CGPointMake(point.x + _xlineLength/2, __kBorderSep);
    [bezierPath addLineToPoint:point];
    [bezierPath addArcWithCenter:CGPointMake(point.x ,__kCornerLength + __kBorderSep) radius:__kCornerLength startAngle:1.5 * M_PI endAngle:2 * M_PI clockwise:YES];
    point = CGPointMake(point.x + __kCornerLength, point.y + _ylineLength);
    [bezierPath addLineToPoint:point];
    [bezierPath addArcWithCenter:CGPointMake(point.x - __kCornerLength , point.y) radius:__kCornerLength startAngle:2 * M_PI endAngle:M_PI_2 clockwise:YES];
    point = CGPointMake(point.x - _xlineLength/2 + __kTriangleShortSideLength*__kTriangleFactor, point.y + __kCornerLength);
    [bezierPath addLineToPoint:point];
    [bezierPath addArcWithCenter:CGPointMake(__kCornerLength , point.y - __kCornerLength) radius:__kCornerLength startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    point = CGPointMake(0, __kBorderSep + __kCornerLength);
    [bezierPath addLineToPoint:point];
    
    _maskBorderLayer.path = bezierPath.CGPath;
    
}

- (void)downPath {
    
    [self upPath];
    _maskBorderLayer.transform = CATransform3DMakeRotation(M_PI, 0.5, 0, 0);
    _maskBorderLayer.transform = CATransform3DTranslate(_maskBorderLayer.transform, 0, -self.frame.size.height, 0);
    
}

@end
