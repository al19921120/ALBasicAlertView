//
//  ALMessTextField.h
//  ALBasicAlertView
//
//  Created by hwt on 16/7/12.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTypeViewProtocol.h"

@interface ALMessTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, weak) id<ALTypeViewProtocol> alDelegate;

@end
