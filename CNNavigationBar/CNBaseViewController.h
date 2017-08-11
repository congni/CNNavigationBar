//
//  CNBaseViewController.h
//  CNNavigationDemo
//
//  Created by 葱泥 on 16/7/29.
//  Copyright © 2016年 葱泥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNNavigationBar.h"


static NSString *kCNNavigationBarBackgroundColor = @"kCNNavigationBarBackgroundColor";
static NSString *kCNNavigationBarTitleColor      = @"kCNNavigationBarTitleColor";
static NSString *kCNNavigationBarTitleFont       = @"kCNNavigationBarTitleFont";
static NSString *kCNNavigationBarLeftTitleColor  = @"kCNNavigationBarLeftTitleColor";
static NSString *kCNNavigationBarLeftTitleFont   = @"kCNNavigationBarLeftTitleFont";
static NSString *kCNNavigationBarLeftIconImage   = @"kCNNavigationBarLeftIconImage";
static NSString *kCNNavigationBarSpaceOffset     = @"kCNNavigationBarSpaceOffset";


/**
 *  基础UIViewController类，其包含了自定义的NavigationBar和UI容器contentView
 */
@interface CNBaseViewController : UIViewController {
    BOOL _isAnimationing;
}

/**
 *  自定义的NavigationBar
 */
@property (nonatomic, strong) CNNavigationBar *navigationBar;
/**
 *  UI容器contentView
 */
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGRect contentFrame;

/**
 *  设置NavigationBar(子类可以重写此方法)
 */
- (void)navigationBarSetting __attribute__ ((objc_requires_super));

/**
 *  全局设置NavigationBar。(具体参数，可以参考源文件);
 *
 *  @param paramDictionary NavigationBar设定参数字典
 */
+ (void)globalSettingNavigationBar:(NSDictionary *)paramDictionary;

/**
 *  隐藏bar
 *
 *  @param isHiden 是否隐藏，如果YES，则隐藏bar，如果NO，则显示Bar
 */
- (void)hidenNavigationBar:(BOOL)isHiden;

@end
