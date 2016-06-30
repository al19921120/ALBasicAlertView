//
//  ALBasicAlertView.h  带有MaskView
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ALAlertViewType) {
    ALAlertViewTypeNormal,
    ALAlertViewTypeOnlyText,
    ALAlertViewTypeList,
};

typedef void(^ConfirmBlock)(void);


@interface ALAlertDataModel : NSObject

/**
 *  text,  messModel typeList时为nibName
 */
@property (nonatomic, copy) NSString *mess;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) NSArray *data;

+ (instancetype)getBasicModel;

@end

@protocol ALBasicAlertViewProtocol <NSObject>

- (void)didSelectBtn:(NSNumber *)isConfirmBtn data:(NSArray *)returnArr;

@end

@interface ALBasicAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame alertBounds:(CGRect)alertBounds titleSetting:(ALAlertDataModel *)titleModel messageSetting:(ALAlertDataModel *)messageModel confirmSetting:(ALAlertDataModel *)confirmModel cancelSetting:(ALAlertDataModel *)cancelModel type:(ALAlertViewType)type;

@property (nonatomic, weak) id<ALBasicAlertViewProtocol> delegate;

@property (nonatomic, weak, readonly) UIView *alertView;

- (void)popIn;
- (void)popOut:(void(^)())completion;

@end
