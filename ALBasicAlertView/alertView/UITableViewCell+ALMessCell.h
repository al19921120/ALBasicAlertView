//
//  UITableViewCell+ALMessCell.h
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedChangeBlock)(void);
@interface UITableViewCell (ALMessCell)

@property (nonatomic, strong) id ALMessData;
@property (nonatomic, strong) NSNumber *isDataSelected;
@property (nonatomic, copy) SelectedChangeBlock block;

@end
