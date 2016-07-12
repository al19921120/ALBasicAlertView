//
//  ALMessTextField.m
//  ALBasicAlertView
//
//  Created by hwt on 16/7/12.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import "ALMessTextField.h"

@implementation ALMessTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    return self;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        
        for(UIView *view in self.subviews) {
            
            if ( ![[view class] isSubclassOfClass:[UITextField class]] ) {
                [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            }
        }
        return NO;
    }

    return YES;
    
}

#pragma mark - delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];

    if ([self.alDelegate respondsToSelector:@selector(didAddObj:status:)]) {
        [self.alDelegate performSelector:@selector(didAddObj:status:) withObject:self.text withObject:nil];
    }

}

@end
