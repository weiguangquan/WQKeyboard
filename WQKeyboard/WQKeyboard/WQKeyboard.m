//
//  WQKeyboard.m
//  WQKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "WQKeyboard.h"

@interface WQKeyboard ()
//字母按钮数组
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *lettering;
//数字按钮数组
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberArr;

@property (strong, nonatomic) IBOutlet UIView *keyboardView;
//数字删除键
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
//输入框
@property (nonatomic, weak) UITextField<UITextInput> *textInput;
//上档键
@property (weak, nonatomic) IBOutlet UIButton *shiftBtn;
//字母键盘删除按钮
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
//切换键盘
@property (weak, nonatomic) IBOutlet UIButton *handoverBtn;
//空格按钮
@property (weak, nonatomic) IBOutlet UIButton *spaceBtn;
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;
//字母键盘
@property (weak, nonatomic) IBOutlet UIView *letterView;
//大小写开关
@property (assign, nonatomic) BOOL isCapital;
//字母数组
@property (strong, nonatomic) NSArray *letteringArr;
//数字数组
@property (strong, nonatomic) NSArray *numberArray;
@end

@implementation WQKeyboard

- (id)initWithInputType:(WQInputType)inputType
{
    self = [super init];
    
    if(self)
    {
        // 通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(editingDidBegin:)
                                                     name:UITextFieldTextDidBeginEditingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(editingDidEnd:)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:nil];

        // 添加keyboardview
        [[NSBundle mainBundle] loadNibNamed:@"WQKeyboard" owner:self options:nil];
        self.frame = CGRectMake(0, 0, SYS_DEVICE_WIDTH, 216);
        self.keyboardView.frame = self.frame;
        [self addSubview:self.keyboardView];
        
        // 设置图片
        [self.deleteBtn setImage:[UIImage imageNamed:@"WQKeyboard.bundle/image/del.png"]
                        forState:UIControlStateNormal];
        [self.delBtn setImage:[UIImage imageNamed:@"WQKeyboard.bundle/image/del.png"]
                     forState:UIControlStateNormal];
        [self.shiftBtn setImage:[UIImage imageNamed:@"WQKeyboard.bundle/image/shift.png"]
                       forState:UIControlStateNormal];
        [self.spaceBtn setImage:[UIImage imageNamed:@"WQKeyboard.bundle/image/logo.png"]
                       forState:UIControlStateNormal];
        self.inputType = inputType;
        
    }
    
    
    return self;
}

- (void)setInterval:(NSNumber *)interval
{
    _interval = interval;
}
- (void)setLength:(NSNumber *)length
{
    _length = length;
}
- (void)setInputType:(WQInputType)inputType
{
    UIButton *xBtn = [self viewWithTag:1011];
    UIButton *dotBtn = [self viewWithTag:1010];
    UIButton *ABCBtn = [self viewWithTag:1113];
    
    _inputType = inputType;
    
    switch (inputType)
    {
            // 浮点数键盘
        case WQFloatInputType:
        {
            xBtn.hidden = YES;
            dotBtn.hidden = NO;
            //禁止切换输入方式
            ABCBtn.enabled = NO;
            [ABCBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        }
            // 身份证键盘
        case WQIDCardInputType:
        {
            xBtn.hidden = NO;
            dotBtn.hidden = YES;
            //禁止切换输入方式
            ABCBtn.enabled = NO;
            [ABCBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        }
            // 整数键盘
        case WQIntInputType:
        {
            xBtn.hidden = YES;
            dotBtn.hidden = YES;
            [self numberViewLoad];
            //禁止切换输入方式
            ABCBtn.enabled = NO;
            [ABCBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        }
            // 字母键盘
        case WQLetterType:
        {
            //初始化 设置_isCapital=YES；
            self.isCapital = YES;
            [self letterViewLoad];
            
            
            
            break;
        }
    }
}
//初始化数字键盘
-(void)numberViewLoad
{
    _numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    //默认随机数字键盘
    [self keyBoardRandom:YES];
}
//变换字母大小写 and 初始化字母键盘
-(void)letterViewLoad
{
    if (self.isCapital)
    {
        _letteringArr = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    }else
    {
        _letteringArr = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    }
    //默认随机字母键盘
    [self keyBoardRandom:NO];
    self.isCapital =!self.isCapital;
    [self reloadKeyBoardView:NO];
    _letterView.hidden = NO;
}
//刷新键盘显示顺序
-(void)reloadKeyBoardView :(BOOL)isNumber
{
    int i = 0;
    if (isNumber)
    {
        for (UIButton *letBtn in _numberArr)
        {
            [letBtn setTitle:_numberArray[i] forState:UIControlStateNormal];
            i++;
        }
    }else
    {
        for (UIButton *letBtn in _lettering)
        {
            [letBtn setTitle:_letteringArr[i] forState:UIControlStateNormal];
            i++;
        }
    }
    
}
//键盘打乱
-(void)keyBoardRandom:(BOOL)isNumberKeyBoard
{
    // 对数组乱序 根据传值判断是什么类型键盘
    if (isNumberKeyBoard)
    {
        _numberArray = [_numberArray sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            int seed = arc4random_uniform(2);
            
            if (seed) {
                return [str1 compare:str2];
            } else {
                return [str2 compare:str1];
            }
            
        }];
    }else
    {
        _letteringArr = [_letteringArr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            int seed = arc4random_uniform(2);
            
            if (seed) {
                return [str1 compare:str2];
            } else {
                return [str2 compare:str1];
            }
        }];
    }
    [self reloadKeyBoardView:isNumberKeyBoard];
    
}
//切换键盘大小写
-(void)keyboardCapitalHandover
{
    [self letterViewLoad];
}
//键盘点击
- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1010:
        {
            // 小数点
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."])
                [self.textInput insertText:@"."];
        }
            break;
        case 1011:
        {
            // 身份证X
            if(self.textInput.text.length == 17 && ![self.textInput.text containsString:@"X"])
                [self.textInput insertText:@"X"];
        }
            break;
        case 1012:
        {
            // 删除
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:
        {
            // 确认
            [self.textInput resignFirstResponder];
        }
            break;
        case 1113:
        {
            UIButton *xBtn = [self viewWithTag:1011];
            UIButton *dotBtn = [self viewWithTag:1010];
            xBtn.hidden= YES;
            dotBtn.hidden =YES;
            // 切换
            if (self.letterView.hidden)
            {
                self.letterView.hidden = NO;
            }else
            {
                self.letterView.hidden = YES;
                //字母键盘切换显示方式
                if (_inputType == WQLetterType)
                {
                    xBtn.hidden = YES;
                    dotBtn.hidden = NO;
                }
            }
            
        }
            break;
        case 1114:
        {
            // 空格
            [self.textInput insertText:@" "];
        }
            break;
        case 1111:
        {
            // 大小写切换
            [self keyboardCapitalHandover];
        }
            break;
        case 1110:
        {
            // 字母
            [self.textInput insertText:sender.titleLabel.text];
        }
            break;
        default:
        {
            // 数字
            NSString *text = sender.titleLabel.text;
            [self.textInput insertText:text];
            
            if(self.interval && (self.textInput.text.length+1) % ([self.interval integerValue] + 1) == 0)
                [self.textInput insertText:@" "];
        }
            break;
    }
    //输入长度限制
    if (self.length && self.textInput.text.length> [self.length integerValue])
    {
        [self.textInput deleteBackward];
    }
}

#pragma mark -
#pragma mark - Notification Action
- (void)editingDidBegin:(NSNotification *)notification {
    //调用键盘时 重置键盘大小写
    if (_isCapital)
    {
        [self letterViewLoad];
    }
    if (![notification.object conformsToProtocol:@protocol(UITextInput)])
    {
        self.textInput = nil;
        return;
    }
    self.textInput = notification.object;
}

- (void)editingDidEnd:(NSNotification *)notification
{
    self.textInput = nil;
    
    //防止切换后键盘显示混乱
    if (_inputType != WQLetterType)
    {
        _letterView.hidden = YES;
    }else
    {
        _letterView.hidden = NO;
    }
    
    
    
}
#pragma mark -
#pragma mark - UIKeyInput Protocol


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
