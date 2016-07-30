//
//  CNBaseViewController.m
//  CNNavigationDemo
//
//  Created by 葱泥 on 16/7/29.
//  Copyright © 2016年 葱泥. All rights reserved.
//

#import "CNBaseViewController.h"


static NSDictionary *globalSettingDictionary = nil;


@interface CNBaseViewController ()

@end

@implementation CNBaseViewController


#pragma mark -Lifecycle
#pragma 初始化
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self initSubView];
    }
    
    return self;
}

#pragma mark viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.contentView];
}

#pragma mark viewWillLayoutSubviews
- (void)viewWillLayoutSubviews {
    float barHeight = [self.navigationBar navigationBarStatueHeight];
    self.contentView.frame = CGRectMake(0, barHeight, self.view.frame.size.width, self.view.frame.size.height - barHeight);
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubView];
}

#pragma mark -Private Method
#pragma mark UI初始化
- (void)initSubView {
    if (self.navigationBar == nil) {
        self.navigationBar = [[CNNavigationBar alloc] init];
        self.contentView = [[UIView alloc] init];
        [self navigationBarSetting];
    }
    
    float barHeight = [self.navigationBar navigationBarStatueHeight];
    self.contentView.frame = CGRectMake(0, barHeight, self.view.frame.size.width, self.view.frame.size.height - barHeight);
}

#pragma mark bar设置
- (void)navigationBarSetting {
    self.navigationBar.title = @"标题";
    
    if (globalSettingDictionary) {
        self.navigationBar.backgroundColor      = globalSettingDictionary[kCNNavigationBarBackgroundColor];
        self.navigationBar.titleLabelFont       = globalSettingDictionary[kCNNavigationBarTitleFont];
        self.navigationBar.titleLabelColor      = globalSettingDictionary[kCNNavigationBarTitleColor];
        self.navigationBar.leftButtonTitleFont  = globalSettingDictionary[kCNNavigationBarLeftTitleFont];
        self.navigationBar.leftButtonTitleColor = globalSettingDictionary[kCNNavigationBarLeftTitleColor];
        self.navigationBar.leftButtonIconImage  = globalSettingDictionary[kCNNavigationBarLeftIconImage];
    } else {
        self.navigationBar.titleLabelFont      = [UIFont systemFontOfSize:18.0];
        self.navigationBar.leftButtonTitleFont = [UIFont systemFontOfSize:14.0];
        self.navigationBar.backgroundColor     = [UIColor redColor];
        self.navigationBar.rightButtonFont     = [UIFont systemFontOfSize:14.0];
    }
}

#pragma mark -Public Method
#pragma mark 全局设置Bar
+ (void)globalSettingNavigationBar:(NSDictionary *)paramDictionary {
    globalSettingDictionary = paramDictionary;
}

@end
