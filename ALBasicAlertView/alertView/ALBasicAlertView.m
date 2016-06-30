//
//  ALBasicAlertView.m
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//


#import "ALBasicAlertView.h"
#import "ALMessTableView.h"

@implementation ALAlertDataModel

+ (instancetype)getBasicModel {
    
    ALAlertDataModel *model = [[ALAlertDataModel alloc] init];
    
    
    return model;
}

- (NSString *)mess {
  
    if (_mess) {
        return _mess;
    }
    return @"空";
    
}

- (UIColor *)color {
    if (_color) {
        return _color;
    }
    return [UIColor blackColor];
}

- (UIFont *)font {
    if (_font) {
        return _font;
    }
    return [UIFont systemFontOfSize:14];
    
}

@end

#define horizonSpace 10
#define btnHeight 44
#define alertBackgroundColor [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1]

@implementation ALBasicAlertView {
    
    ALAlertDataModel *_titleModel;
    ALAlertDataModel *_messModel;
    ALAlertDataModel *_confirmModel;
    ALAlertDataModel *_cancelModel;
    NSMutableArray *_selectedDataArray;
    
    UIView *_topView;
    UILabel *_titleLabel;

    CGFloat _alertWidth;
    CGFloat _alertHeight;
    
}

- (instancetype)initWithFrame:(CGRect)frame alertBounds:(CGRect)alertBounds titleSetting:(ALAlertDataModel *)titleModel messageSetting:(ALAlertDataModel *)messageModel confirmSetting:(ALAlertDataModel *)confirmModel cancelSetting:(ALAlertDataModel *)cancelModel type:(ALAlertViewType)type {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _selectedDataArray = [NSMutableArray array];

        _titleModel = titleModel;
        _messModel = messageModel;
        _confirmModel = confirmModel;
        _cancelModel = cancelModel;
        
        [self initAlertViewWithFrame:alertBounds];
        [self initBasicView];
        
        switch (type) {
            case ALAlertViewTypeNormal:
                [self normalType];
                break;
            case ALAlertViewTypeOnlyText:
                [self onlyTextType];
                break;
            case ALAlertViewTypeList:
                [self listType];
                break;
            default:
                break;
        }
        
    }
    
    return self;
}

- (void)initAlertViewWithFrame:(CGRect)frame {
    
    NSUInteger alertViewX = (CGRectGetWidth(self.frame) - frame.size.width)/2;
    NSUInteger alertViewY = (CGRectGetHeight(self.frame) - frame.size.height)/2 - 32;

    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(alertViewX, alertViewY, frame.size.width, frame.size.height)];
    alertView.layer.cornerRadius = 5;
    alertView.clipsToBounds = YES;
    alertView.backgroundColor = alertBackgroundColor;
    [self addSubview:alertView];
    _alertView = alertView;
    
    _alertWidth = CGRectGetWidth(_alertView.frame);
    _alertHeight = CGRectGetHeight(_alertView.frame);

}

- (void)initBasicView {
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _alertWidth, CGRectGetHeight(_alertView.frame) - btnHeight)];
    _topView.backgroundColor = [UIColor whiteColor];
    [_alertView addSubview:_topView];
    
    CGFloat btnTop = CGRectGetHeight(_topView.frame) + 1;
    UIButton *confirmBtn, *cancelBtn;
    if (_confirmModel) {
        
        CGFloat confirmBtnWidth, confirmBtnLeft;
        if (_cancelModel) {
            confirmBtnWidth = (_alertWidth - 1) / 2;
            confirmBtnLeft = confirmBtnWidth + 1;
        }
        else {
            confirmBtnWidth = _alertWidth;
            confirmBtnLeft = 0;
        }
        
        confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(confirmBtnLeft, btnTop, confirmBtnWidth, btnHeight);
        confirmBtn.tag = 10;
        [confirmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.backgroundColor = [UIColor whiteColor];
        [confirmBtn setTitle:_confirmModel.mess forState:UIControlStateNormal];
        [confirmBtn setTitleColor:_confirmModel.color forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = _confirmModel.font;
        [_alertView addSubview:confirmBtn];
        
    }
    if (_cancelModel) {
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, btnTop, CGRectGetWidth(confirmBtn.frame), btnHeight);
        cancelBtn.tag = 11;
        [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitle:_cancelModel.mess forState:UIControlStateNormal];
        [cancelBtn setTitleColor:_cancelModel.color forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = _cancelModel.font;
        [_alertView addSubview:cancelBtn];
    }
    
    
}

- (void)initTitleLabel {
    if (_titleModel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(horizonSpace, 0, _alertWidth - 2*horizonSpace, 40)];
        _titleLabel.text = _titleModel.mess;
        _titleLabel.textColor = _titleModel.color;
        _titleLabel.font = _titleModel.font;
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:_titleLabel];
        //TODO:由宽高重新计算位置
    }
}

#pragma mark - type

- (void)normalType {
    
    [self initTitleLabel];
    [self onlyTextType];
    
}

- (void)onlyTextType {
    
    CGFloat messTop;
    CGFloat messHeight;
    if (_titleLabel) {
        messTop = CGRectGetHeight(_titleLabel.frame) + 10;
    }
    else {
        messTop = 10;
    }
    messHeight = CGRectGetHeight(_topView.frame) - messTop;
    
    UILabel *messLabel = [[UILabel alloc] initWithFrame:CGRectMake(horizonSpace, messTop, _alertWidth - 2*horizonSpace, messHeight)];
    messLabel.text = _messModel.mess;
    messLabel.textColor = _messModel.color;
    messLabel.font = _messModel.font;
    messLabel.numberOfLines = 0;
    messLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:messLabel];
    
    
}

- (void)listType {
    
    [self initTitleLabel];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat messTop = CGRectGetHeight(_titleLabel.frame) + 10;
    CGFloat messHeight = CGRectGetHeight(_topView.frame) - messTop;
    
    CALayer *sepLine = [CALayer layer];
    sepLine.frame = CGRectMake(0, messTop - 1, _alertWidth, 1);
    sepLine.backgroundColor = alertBackgroundColor.CGColor;
    [_topView.layer addSublayer:sepLine];
    
    ALMessTableView *messTableView = [[ALMessTableView alloc] initWithFrame:CGRectMake(horizonSpace, messTop, _alertWidth - 2*horizonSpace, messHeight) style:UITableViewStylePlain cellName:_messModel.mess];
    messTableView.dataArray = _messModel.data;
    messTableView.addSelectedObjBlock = ^(id obj){
        
        if ([_selectedDataArray containsObject:obj]) {
            [_selectedDataArray removeObject:obj];
        }
        else {
            [_selectedDataArray addObject:obj];
        }
    };
    [_topView addSubview:messTableView];
    
}

#pragma mark -

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_alertView];
    if (![_alertView pointInside:point withEvent:nil]) {
        [self popOut:^{
            [_selectedDataArray removeAllObjects];
            [self removeFromSuperview];
        }];
    }
    
}

- (void)btnAction:(UIButton *)btn {
    [self popOut:^{
        
        NSNumber *isConfirmBtn = @1;
        if (btn.tag == 10) {
            isConfirmBtn = @1;
        }
        if (btn.tag == 11) {
            isConfirmBtn = @0;
        }
        if ([_delegate respondsToSelector:@selector(didSelectBtn:data:)]) {
            [_delegate performSelector:@selector(didSelectBtn:data:) withObject:isConfirmBtn withObject:_selectedDataArray];
        }
        
        [_selectedDataArray removeAllObjects];
        [self removeFromSuperview];
        
    }];
}

#pragma mark -

- (void)popIn {
    
    CABasicAnimation *animeFadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animeFadeIn.duration = 0.3;
    animeFadeIn.fromValue = @0;
    animeFadeIn.toValue = @1;
    [self.layer addAnimation:animeFadeIn forKey:@"animFadeIn"];
    
    [self.alertView.layer addAnimation:[ALBasicAlertView animationPopIn] forKey:@"animPopIn"];
}

- (void)popOut:(void(^)())completion {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

+ (CAKeyframeAnimation *)animationPopIn {
    CAKeyframeAnimation *animePopIn = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animePopIn.duration = 0.3;
    animePopIn.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                          [NSValue valueWithCATransform3D:CATransform3DIdentity]
                          ];
    animePopIn.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animePopIn.keyTimes = @[@0, @0.5, @0.75, @1];
    
    return animePopIn;
}

#pragma mark - 



- (void)dealloc {
//    NSLog(@"** - dealloc - %@ - **", NSStringFromClass([self class]));
}

@end
