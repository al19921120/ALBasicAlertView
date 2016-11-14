//
//  ALDetailAlertView.h
//  MYShengYiJia
//
//  Created by hwt on 16/10/13.
//  Copyright © 2016年 MYun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ALDetailAlertOrientation) {
    ALDetailAlertOrientationUp,
    ALDetailAlertOrientationDown,
    ALDetailAlertOrientationLeft,  //not
    ALDetailAlertOrientationRight, //not
};

@interface ALDetailAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame subView:(UIView *)view;

- (void)popInFrom:(CGPoint)point orientation:(ALDetailAlertOrientation)orientation;
- (void)popOut:(void(^)())completion;

@end
