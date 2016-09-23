//
//  ViewController.m
//  WQKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "ViewController.h"
#import "WQKeyboard.h"
#import "UITextField+WQKeyboard.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UITextField *textFiledTwo;
@property (weak, nonatomic) IBOutlet UITextField *textFiledThree;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textFiled.wq_inputType = WQIntInputType;
    self.textFiledTwo.wq_inputType = WQIDCardInputType;
    self.textFiledThree.wq_inputType = WQLetterType;
    
//    self.textFiled.wq_interval = 4;
//    self.textFiledTwo.wq_interval = 6;
    
//    self.textFiled.wq_inputAccessoryText = @"请输入银行卡号";
//    self.textFiledTwo.wq_inputAccessoryText = @"请输入身份证号";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
