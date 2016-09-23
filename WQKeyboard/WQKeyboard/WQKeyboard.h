//
//  WQKeyboard.h
//  WQKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度

typedef NS_ENUM(NSUInteger, WQInputType) {
    WQIntInputType,        // 整数键盘
    WQFloatInputType,      // 浮点数键盘
    WQIDCardInputType,     // 身份证键盘
    WQLetterType,        // 字母键盘
};

@interface WQKeyboard : UIView

@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, assign) WQInputType inputType;        // 键盘类型
@property (nonatomic, strong) NSNumber *interval;           // 每隔多少个数字空一格
@property (nonatomic, strong) NSNumber *length;           // 输入框限制长度
- (id)initWithInputType:(WQInputType)inputType;


@end
