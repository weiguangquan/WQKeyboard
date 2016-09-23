//
//  UITextField+WQKeyboard.m
//  WQKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "UITextField+WQKeyboard.h"
#import <objc/runtime.h>

@implementation UITextField (WQKeyboard)

#pragma mark -
#pragma mark -  Setter

- (void)setWq_inputType:(WQInputType)wq_inputType
{
    WQKeyboard *inputView = [[WQKeyboard alloc] initWithInputType:wq_inputType];
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(wq_inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWq_interval:(NSInteger)wq_interval
{
    if([self.inputView isKindOfClass:[WQKeyboard class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(wq_interval)];
    objc_setAssociatedObject(self, _cmd, @(wq_interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWq_inputAccessoryText:(NSString *)wq_inputAccessoryText
{
    // inputAccessoryView
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    // 顶部分割线
    UIView *tLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 0.5)];
    tLine.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    // 字体label
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    tLabel.text = wq_inputAccessoryText;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont systemFontOfSize:14.0];
    tLabel.backgroundColor = [UIColor whiteColor];
    
    [tView addSubview:tLabel];
    [tView addSubview:tLine];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, wq_inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setWq_limitationOfLength:(NSInteger)wq_limitationOfLength
{
    if([self.inputView isKindOfClass:[WQKeyboard class]])
        [self.inputView performSelector:@selector(setLength:) withObject:@(wq_limitationOfLength)];
    objc_setAssociatedObject(self, _cmd, @(wq_limitationOfLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark -
#pragma mark -  Getter

- (WQInputType)wq_inputType
{
    return [objc_getAssociatedObject(self, @selector(setWq_inputType:)) integerValue];
}

- (NSInteger)wq_interval
{
    return [objc_getAssociatedObject(self, @selector(setWq_interval:)) integerValue];
}

- (NSString *)wq_inputAccessoryText
{
    return objc_getAssociatedObject(self, @selector(wq_inputAccessoryText));
}
- (NSInteger)wq_limitationOfLength
{
    return [objc_getAssociatedObject(self, @selector(setWq_limitationOfLength:)) integerValue];
}


@end
