//
//  AddBankCardViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/9.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "UIButton+YPTextFieldButton.h"
#import <AFNetworking.h>

@interface AddBankCardViewController () <UITextFieldDelegate>
@property (nonatomic, strong)UITextField *numField;
@property (nonatomic, strong)UITextField *nameField;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, copy)NSMutableDictionary *bankDict;
@end

@implementation AddBankCardViewController
- (NSMutableDictionary *)bankDict
{
    if (!_bankDict) {
        _bankDict = [NSMutableDictionary dictionary];
    }
    return _bankDict;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self createUI];
}

#pragma mark - createNav
- (void)createNav
{
    self.view.backgroundColor = ViewBacgroundColor;
    self.navigationItem.title = @"添加银行卡";
    
}

- (void)createUI
{
    UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STANDNAV(44), WIDTHS, 44 * HEIGHTMAKE)];
    warnLabel.text = @"  请绑定持卡人本人的银行卡";
    warnLabel.font = [UIFont systemFontOfSize:12 * WIDTHMAKE];
    warnLabel.textColor = [UIColor grayColor];
    [self.view addSubview:warnLabel];

    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(warnLabel.frame), WIDTHS, 44 * HEIGHTMAKE)];
    self.nameField = nameField;
    nameField.backgroundColor = [UIColor whiteColor];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    nameLabel.text = @"持卡人:";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameField.leftView = nameLabel;
    nameField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:nameField];
    self.nameLabel = nameLabel;
    
    UITextField *numField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameField.frame) + 1, WIDTHS, 44 * HEIGHTMAKE)];
    numField.delegate = self;
    numField.backgroundColor = [UIColor whiteColor];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * WIDTHMAKE, 44 * HEIGHTMAKE)];
    numLabel.text = @"卡 号:";
    numLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
    dic[NSForegroundColorAttributeName] = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [numField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"银行卡号" attributes:dic]];
    numField.leftView = numLabel;
    numField.leftViewMode = UITextFieldViewModeAlways;
    numField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:numField];
    self.numField = numField;
    
    UIButton *nextBtn = [UIButton buttonWithLoginRegisterNormalTitle:@"下一步" highlightTitle:@"下一步" addTarget:self action:@selector(nextBtnClick)];
    nextBtn.frame = CGRectMake((WIDTHS - 355 * WIDTHMAKE) / 2, CGRectGetMaxY(numField.frame) + 46 * HEIGHTMAKE, 355 * WIDTHMAKE, 45 * HEIGHTMAKE);
    [nextBtn setTitle:@"下一步" forState:UIControlStateDisabled];
    [nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.view addSubview:nextBtn];
    self.nextBtn = nextBtn;
}

#pragma mark - 下一步
- (void)nextBtnClick
{
    __weak typeof(self) weakSelf = self;
    //去掉空格
    NSString *number = [self.numField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //取后4位
    NSString *backFourNum = [number substringFromIndex:number.length - 4];
    //跳转下一步
    if (!self.nameField.hasText || !self.numField.hasText) {
        NSLog(@"输入不完整");
    } else {
        if ([self validateBankCardNumber:self.numField.text]) {
            //提交银行卡信息
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"num"] = number;
            [manager POST:@"http://192.168.2.168:8080/user/getBank" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [weakSelf.bankDict setValue:backFourNum forKeyPath:@"backFourNum"];
                [weakSelf.bankDict setValue:[responseObject[@"data"] valueForKeyPath:@"name"] forKeyPath:@"name"];
                if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"邮储"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"邮政银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"邮政" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"成都商业银行"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"成都银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"中国" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"工商"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"工商银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"中国" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"建设"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"建设银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"建行" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"交通"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"交通银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"建行" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"农业"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"农业银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"农行" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"兴业"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"兴业银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"建行" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"招商"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"招商银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"中国" forKeyPath:@"bg"];
                } else if ([[responseObject[@"data"] valueForKeyPath:@"name"] rangeOfString:@"中国银行"].location != NSNotFound) {
                    [weakSelf.bankDict setValue:@"中国银行" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"中国" forKeyPath:@"bg"];
                } else {
                    [weakSelf.bankDict setValue:@"默认头像" forKeyPath:@"icon"];
                    [weakSelf.bankDict setValue:@"建行" forKeyPath:@"bg"];
                }
                
                weakSelf.bankCardBlock(weakSelf.bankDict);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@---",error);
            }];
        } else {
            NSLog(@"银行卡输入错误");
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//银行卡位数
- (BOOL) validateBankCardNumber:(NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *number = [bankCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:number];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.numField) {
        // 4位分隔银行卡卡号
        NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if ([newString stringByReplacingOccurrencesOfString:@" " withString:@""].length >= 21) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
    }
    return YES;
}

@end
