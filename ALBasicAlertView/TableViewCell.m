//
//  TableViewCell.m
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import "TableViewCell.h"
#import "UITableViewCell+ALMessCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)s:(id)sender {
    
    BOOL isSelected = ![self.isDataSelected boolValue];
    self.isDataSelected = @(isSelected);
    [self setNeedsLayout];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if ([self.isDataSelected boolValue]) {
        self.backgroundColor = [UIColor blackColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}

@end
