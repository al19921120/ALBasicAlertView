//
//  ALBasicAlertView.h  带有MaskView
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ALTypeViewProtocol.h"

typedef NS_ENUM(NSUInteger, ALAlertViewType) {
    ALAlertViewTypeNormal,
    ALAlertViewTypeOnlyText,
    ALAlertViewTypeList,
    ALAlertViewTypeInput,
};

typedef void(^ConfirmBlock)(void);
@class ALBasicAlertView;

@interface ALAlertDataModel : NSObject

/**
 *  text,  messModel typeList时为nibName
 */
@property (nonatomic, copy) NSString *mess;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) NSArray *data;

//list only
@property (nonatomic, strong) NSNumber *isMultiSelection;

+ (instancetype)getBasicModel;

@end

@protocol ALBasicAlertViewProtocol <NSObject>

@optional
- (void)didSelectBtn:(NSNumber *)isConfirmBtn data:(NSArray *)returnArr;
- (void)alalertView:(ALBasicAlertView *)alAlertView data:(NSDictionary *)returnDic;

@end

@interface ALBasicAlertView : UIView <ALTypeViewProtocol>

- (instancetype)initWithFrame:(CGRect)frame alertBounds:(CGRect)alertBounds titleSetting:(ALAlertDataModel *)titleModel messageSetting:(ALAlertDataModel *)messageModel confirmSetting:(ALAlertDataModel *)confirmModel cancelSetting:(ALAlertDataModel *)cancelModel type:(ALAlertViewType)type;

@property (nonatomic, weak) id<ALBasicAlertViewProtocol> delegate;

@property (nonatomic, weak, readonly) UIView *alertView;
@property (nonatomic, assign, readonly) ALAlertViewType type;

- (void)popIn;
- (void)popOut:(void(^)())completion;

@end
