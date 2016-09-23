//
//  UITextField+WQKeyboard.h
//  WQKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQKeyboard.h"

@interface UITextField (WQKeyboard)

@property (nonatomic, assign) WQInputType wq_inputType;     // 键盘类型
@property (nonatomic, assign) NSInteger wq_interval;        // 每隔多少个数字空一格
@property (nonatomic, assign) NSInteger wq_limitationOfLength;           // 输入框限制长度
@property (nonatomic, copy) NSString *wq_inputAccessoryText;  // inputAccessoryView显示的文字

@end


