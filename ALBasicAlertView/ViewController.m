//
//  ViewController.m
//  ALBasicAlertView
//
//  Created by hwt on 16/6/30.
//  Copyright © 2016年 hwt. All rights reserved.
//

#import "ViewController.h"
#import "ALBasicAlertView.h"
#import "ALDetailAlertView.h"

@interface ViewController () <ALBasicAlertViewProtocol>

@end

#define __kScreenWidth [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ViewController {
    ALAlertDataModel *_titleModel;
    ALAlertDataModel *_messModel;
    ALAlertDataModel *_confirmModel;
    ALAlertDataModel *_cancelModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAlertModels];

}

- (void)initAlertModels {
    
    _titleModel = [[ALAlertDataModel alloc] init];
    _titleModel.mess = @"title";
    _messModel = [[ALAlertDataModel alloc] init];
    _messModel.mess = @"messmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmessmess";
    _confirmModel = [[ALAlertDataModel alloc] init];
    _confirmModel.mess = @"confirm";
    _confirmModel.color = [UIColor blueColor];
    _cancelModel = [[ALAlertDataModel alloc] init];
    _cancelModel.mess = @"cancel";
}

- (IBAction)showNormalAlertView:(id)sender {
    
    ALBasicAlertView *alert = [[ALBasicAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds alertBounds:CGRectMake(10, 100, __kScreenWidth-10, 200) titleSetting:_titleModel messageSetting:_messModel confirmSetting:_confirmModel cancelSetting:_cancelModel type:ALAlertViewTypeNormal];
    alert.delegate = self;
    alert.tag = 10;
    [self.view addSubview:alert];
    [alert popIn];
    
    
    
}
- (IBAction)showOnlyTextAlertView:(id)sender {
    ALBasicAlertView *alert = [[ALBasicAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds alertBounds:CGRectMake(10, 100, __kScreenWidth-10, 200) titleSetting:_titleModel messageSetting:_messModel confirmSetting:_confirmModel cancelSetting:_cancelModel type:ALAlertViewTypeOnlyText];
    alert.delegate = self;
    alert.tag = 11;
    [self.view addSubview:alert];
    [alert popIn];
    
}
- (IBAction)showListAlertView:(id)sender {
    
    _messModel.mess = @"TableViewCell";
    _messModel.data = @[@1,@2,@3];
    _messModel.isMultiSelection = @1;
    
    ALBasicAlertView *alert = [[ALBasicAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds alertBounds:CGRectMake(10, 100, __kScreenWidth-10, 200) titleSetting:_titleModel messageSetting:_messModel confirmSetting:_confirmModel cancelSetting:nil type:ALAlertViewTypeList];
    alert.tag = 12;
    alert.delegate = self;
    [self.view addSubview:alert];
    [alert popIn];
    
}

- (IBAction)showInputAlertView:(id)sender {
    
    _messModel.color = [UIColor blueColor];
    ALBasicAlertView *alert = [[ALBasicAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds alertBounds:CGRectMake(10, 100, __kScreenWidth-10, 200) titleSetting:_titleModel messageSetting:_messModel confirmSetting:_confirmModel cancelSetting:_cancelModel type:ALAlertViewTypeInput];
    alert.tag = 13;
    alert.delegate = self;
    [self.view addSubview:alert];
    [alert popIn];
    
    
    
}

- (IBAction)showDetailAlertView:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    lab.text = @"123123";
    
    ALDetailAlertView *alert = [[ALDetailAlertView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, 200, 130) subView:lab];
    NSLog(@"%@", alert);
    alert.tag = 14;
    [self.view addSubview:alert];
    [alert popInFrom:btn.frame.origin orientation:ALDetailAlertOrientationUp];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ALDetailAlertView *alert = [self.view viewWithTag:14];
    [alert popOut:^{
        
    }];
    [alert removeFromSuperview];
}

//- (void)didSelectBtn:(NSNumber *)isConfirmBtn data:(NSArray *)returnArr {
//    
//    if ([isConfirmBtn boolValue]) {
//        NSLog(@"press confirm %@",returnArr);
//    }
//    else {
//        NSLog(@"press cancel");
//    }
//}

- (void)alalertView:(ALBasicAlertView *)alAlertView didSelectdata:(NSDictionary *)returnDic {
    
    NSLog(@"alView:%@, \n data:%@",alAlertView, returnDic);
    
}

@end
