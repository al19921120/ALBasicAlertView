//
//  UITableViewCell+ALMessCell.h
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTypeViewProtocol.h"

@interface UITableViewCell (ALMessCell)

@property (nonatomic, strong) id ALMessData;
@property (nonatomic, strong) NSNumber *isDataSelected;
@property (nonatomic, weak) id<ALTypeViewProtocol> alDelegate;

@end
