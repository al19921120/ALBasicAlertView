//
//  ALMessTableView.h
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddSelectedObjBlock)(id);
@interface ALMessTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) AddSelectedObjBlock addSelectedObjBlock;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellName:(NSString *)cellName;

@end
