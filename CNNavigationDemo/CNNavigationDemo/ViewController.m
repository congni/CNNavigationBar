//
//  ViewController.m
//  CNNavigationDemo
//
//  Created by 葱泥 on 16/7/29.
//  Copyright © 2016年 葱泥. All rights reserved.
//

#import "ViewController.h"
#import "CNNavigationBar.h"
#import "SecondViewController.h"

@interface ViewController ()<UIWebViewDelegate, CNNavigationBarDelegate>
@property (nonatomic, strong) UIWebView *wbView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBar.title = @"标题";
    self.navigationBar.isHiddenLeftButton = YES;
    self.navigationBar.delegate = self;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"刷新" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addRightButton:cancelButton];
    [self.navigationBar rightButtonForText:@"GO"];
    
    self.wbView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
    self.wbView.delegate = self;
     [self.wbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://twitter.com"]]];
    [self.contentView addSubview:self.wbView];
}

- (void)refresh {
    [self.wbView reload];
}

#pragma mark 右侧按钮点击事件
- (void)navigationBarRightButtonClick {
    SecondViewController *secVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
