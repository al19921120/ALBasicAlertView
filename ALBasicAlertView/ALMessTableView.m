//
//  ALMessTableView.m
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import "ALMessTableView.h"
#import "UITableViewCell+ALMessCell.h"

@implementation ALMessTableView

static NSString *cellId = @"cellId";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellName:(NSString *)cellName {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
        if (nib) {
            [self registerNib:nib forCellReuseIdentifier:cellId];
        }
        
    }
    return self;
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.ALMessData = _dataArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isSelected = ![cell.isDataSelected boolValue];
    cell.isDataSelected = @(isSelected);
    _addSelectedObjBlock(_dataArray[indexPath.row]);
    
}

@end
