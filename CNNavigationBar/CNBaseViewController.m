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

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navigationBar];
    
    float barHeight = [self.navigationBar navigationBarStatueHeight];
    self.contentView.frame = CGRectMake(0, barHeight, self.view.frame.size.width, self.view.frame.size.height - barHeight);
    self.contentFrame = self.contentView.bounds;
    
    self.automaticallyAdjustsScrollViewInsets = false;
}

#pragma mark -Private Method
#pragma mark UI初始化
- (void)initSubView {
    if (self.navigationBar == nil) {
        self.navigationBar = [[CNNavigationBar alloc] init];
        [self navigationBarSetting];
        
        self.contentView = [[UIView alloc] init];
        [self.contentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                               UIViewAutoresizingFlexibleHeight)];
        
        [self.contentView setAutoresizesSubviews:YES];
    }
}

#pragma mark bar设置
- (void)navigationBarSetting {
    self.navigationBar.title = @"标题1111";
    
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
//
- (void)hidenNavigationBar:(BOOL)isHiden {
    if (_isAnimationing) {
        return;
    }
    
    if (isHiden) {
        if (self.navigationBar.frame.origin.y == -self.navigationBar.frame.size.height) {
            return;
        }
        
        self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _isAnimationing = YES;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationBar.frame = CGRectMake(0, -self.navigationBar.frame.size.height, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height);
        } completion:^(BOOL finished) {
            _isAnimationing = NO;
        }];
    } else {
        if (self.navigationBar.frame.origin.y < 0) {
            if (self.navigationBar.frame.origin.y == 0.0) {
                return;
            }
            
            _isAnimationing = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.navigationBar.frame = CGRectMake(0, 0.0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height);
                
            } completion:^(BOOL finished) {
                _isAnimationing = NO;
                self.contentView.frame = CGRectMake(0.0, self.navigationBar.frame.size.height, self.contentView.frame.size.width, self.view.frame.size.height - self.navigationBar.frame.size.height);
            }];
        }
    }
}

@end
