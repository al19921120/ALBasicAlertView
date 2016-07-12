//
//  UITableViewCell+ALMessCell.m
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import "UITableViewCell+ALMessCell.h"
#import <objc/runtime.h>

static const void *messDataKey = &messDataKey;
static const void *isDataSelectedKey = &isDataSelectedKey;
static const void *alDelegateKey = &alDelegateKey;

@implementation UITableViewCell (ALMessCell)

@dynamic ALMessData;

- (id<ALTypeViewProtocol>)alDelegate {
    return objc_getAssociatedObject(self, alDelegateKey);
}

- (void)setAlDelegate:(id<ALTypeViewProtocol>)alDelegate {
    objc_setAssociatedObject(self, alDelegateKey, alDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (NSNumber *)isDataSelected {
    return objc_getAssociatedObject(self, isDataSelectedKey);
}

- (void)setIsDataSelected:(NSNumber *)isDataSelected {
    objc_setAssociatedObject(self, isDataSelectedKey, isDataSelected, OBJC_ASSOCIATION_COPY_NONATOMIC);

    if ([self.alDelegate respondsToSelector:@selector(didAddObj:status:)]) {
        [self.alDelegate performSelector:@selector(didAddObj:status:) withObject:self.ALMessData withObject:isDataSelected];
    }

    [self setNeedsLayout];
}

- (id)ALMessData {
    return objc_getAssociatedObject(self, messDataKey);
}

- (void)setALMessData:(id)ALMessData {
    
    objc_setAssociatedObject(self, messDataKey, ALMessData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
    
}

@end
