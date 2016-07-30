//
//  SecondViewController.m
//  CNNavigationDemo
//
//  Created by 葱泥 on 16/7/30.
//  Copyright © 2016年 葱泥. All rights reserved.
//

#import "SecondViewController.h"
#import "NJKWebViewProgress.h"

@interface SecondViewController ()<CNNavigationBarDelegate, NJKWebViewProgressDelegate>
@property (nonatomic, strong) UIWebView *wbView;
@property (nonatomic, strong) NJKWebViewProgress *webViewProgress;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    self.wbView.delegate = _webViewProgress;
    _webViewProgress.progressDelegate = self;
    
    self.wbView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
    self.wbView.backgroundColor = [UIColor blueColor];
    [self.wbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://congni.tech/"]]];
    [self.contentView addSubview:self.wbView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 自定义设置Bar
- (void)navigationBarSetting {
    [super navigationBarSetting];
    
    /**
     *  设置Title
     */
    self.navigationBar.title = @"第二页";
    /**
     *  代理回调
     */
    self.navigationBar.delegate = self;
    /**
     *  是否是网页
     */
    self.navigationBar.isWebSite = YES;
}

#pragma mark 左侧按钮点击事件
- (void)navigationBarLeftButtonClick {
    [self.wbView goBack];
}

#pragma mark 关闭按钮点击事件
- (void)navigationBarCloseButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    //    NSLog(@"progress   %@", @(progress));
    if (progress != 0.0) {
        self.navigationBar.progress = progress;
    }
    
    if (progress == NJKInteractiveProgressValue) {
        // The web view has finished parsing the document,
        //        NSLog(@"The web view has finished parsing the document");
    }
}

@end
