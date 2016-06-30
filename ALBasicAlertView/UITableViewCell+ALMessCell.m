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

@implementation UITableViewCell (ALMessCell)

@dynamic ALMessData;


- (NSNumber *)isDataSelected {
    return objc_getAssociatedObject(self, isDataSelectedKey);
}

- (void)setIsDataSelected:(NSNumber *)isDataSelected {
    //override
    objc_setAssociatedObject(self, isDataSelectedKey, isDataSelected, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)ALMessData {
    return objc_getAssociatedObject(self, messDataKey);
}

- (void)setALMessData:(id)ALMessData {
    
    objc_setAssociatedObject(self, messDataKey, ALMessData, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setNeedsLayout];
    
}

@end
