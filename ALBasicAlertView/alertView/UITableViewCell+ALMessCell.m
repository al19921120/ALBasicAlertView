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
static const void *blockKey = &blockKey;

@implementation UITableViewCell (ALMessCell)

@dynamic ALMessData;

- (SelectedChangeBlock)block {
    return objc_getAssociatedObject(self, blockKey);
}

- (void)setBlock:(SelectedChangeBlock)block {
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)isDataSelected {
    return objc_getAssociatedObject(self, isDataSelectedKey);
}

- (void)setIsDataSelected:(NSNumber *)isDataSelected {
    objc_setAssociatedObject(self, isDataSelectedKey, isDataSelected, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.block) {
        self.block();
    }
    [self setNeedsLayout];
}

- (id)ALMessData {
    return objc_getAssociatedObject(self, messDataKey);
}

- (void)setALMessData:(id)ALMessData {
    
    objc_setAssociatedObject(self, messDataKey, ALMessData, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setNeedsLayout];
    
}

@end
