//
//  SearchViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/7/29.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTextField.h"
#import "UIView+YPFrameExtension.h"

@interface SearchViewController () <UITextFieldDelegate>
{
    SearchTextField *_search;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
}

#pragma mark - setNav
- (void)setNav
{
    _search = [[SearchTextField alloc] initWithFrame:CGRectMake(0, 0, 260 * WIDTHMAKE, 32 * HEIGHTMAKE) Text:@"搜索游戏名/商品名/关键词"];
    _search.delegate = self;
    _search.returnKeyType = UIReturnKeySearch;
#warning 6p适配
    self.navigationItem.titleView = _search;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_search resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNav];
    [_search becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_search resignFirstResponder];
}
@end
