//
//  CNNavigationBar.h
//  MakeupLessons
//
//  Created by 葱泥 on 16/6/13.
//  Copyright © 2016年 quanXiang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  左侧按钮模式
 */
typedef NS_ENUM(NSInteger, LeftButtonStyle) {
    /**
     *  图片加文字
     */
    LeftButtonStyle_AllWithText       = 1,
    /**
     *  只有图片
     */
    LeftButtonStyle_AllWithOutText    = 2
};

/**
 *  代理回调
 */
@protocol CNNavigationBarDelegate <NSObject>
@optional
/**
 *  左侧按钮点击回调
 */
- (void)navigationBarLeftButtonClick;
/**
 *  右侧按钮点击回调
 */
- (void)navigationBarRightButtonClick;
/**
 *  关闭按钮点击回调
 */
- (void)navigationBarCloseButtonClick;

@end


@class CNIconLabel;
@interface CNNavigationBar : UIView {
    /**
     *  titleLabel
     */
    UILabel *_titleLabel;
    /**
     *  右侧按钮存放容器
     */
    UIView *_rightButtonView;
    /**
     *  左侧按钮
     */
    CNIconLabel *_leftIconLabel;
    /**
     *  右侧按钮
     */
    UIButton *_rightButton;
    /**
     *  右侧按钮存放数组
     */
    NSMutableArray *_rightButtonsMulArray;
    /**
     *  网页进度条
     */
    UIProgressView *_progressView;
    /**
     *  网页关闭按钮
     */
    UIButton *_closeButton;
}

/**
 *  代理
 */
@property (nonatomic, weak) id<CNNavigationBarDelegate>delegate;

/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleLabelFont;
/**
 *  标题颜色
 */
@property (nonatomic, strong) UIColor *titleLabelColor;
/**
 *  左侧按钮字体颜色
 */
@property (nonatomic, strong) UIColor *leftButtonTitleColor;
/**
 *  左侧按钮字体
 */
@property (nonatomic, strong) UIFont *leftButtonTitleFont;
/**
 *  左侧按钮类型
 */
@property (nonatomic, assign) LeftButtonStyle leftButtonStyle;
/**
 *  左侧按钮图标
 */
@property (nonatomic, strong) UIImage *leftButtonIconImage;
/**
 *  左侧按钮标题
 */
@property (nonatomic, strong) NSString *leftButtonTitle;

/**
 *  是否隐藏全部按钮(包括左侧、右侧按钮，只保留标题)
 */
@property (nonatomic, assign) BOOL isHiddenAllButton;
/**
 *  是否隐藏左侧按钮(默认不隐藏)
 */
@property (nonatomic, assign) BOOL isHiddenLeftButton;

/**
 *  右侧按钮字体
 */
@property (nonatomic, strong) UIFont *rightButtonFont;
/**
 *  右侧按钮字体颜色
 */
@property (nonatomic, strong) UIColor *rightButtonTitleColor;

/**
 *  间距
 */
@property (nonatomic, assign) UIOffset spaceOffset;
/**
 *  bar的高度(默认是49.0,注意：这里的是bar的高度，不包括状态栏的高度，状态栏会自动加载的)
 */
@property (nonatomic, assign) float navigationBarHeight;

/**
 *  是否是网页端
 */
@property (nonatomic, assign) BOOL isWebSite;
/**
 *  网页加载进度
 */
@property (nonatomic, assign) float progress;
/**
 *  网页加载进度条颜色值
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 *  网页，关闭按钮标题颜色值
 */
@property (nonatomic, strong) UIColor *closeButtonTitleColor;
/**
 *  网页，关闭按钮标题字体
 */
@property (nonatomic, strong) UIFont *closeButtonTitleFont;
/**
 *  网页，是否显示关闭按钮
 */
@property (nonatomic, assign) BOOL isShowCloseButton;

/**
 *  bar高度(注：此为正确获取Bar高度的方式)
 *
 *  @return 高度
 */
- (float)navigationBarStatueHeight;

/**
 *  设置右侧按钮为图片按钮
 *
 *  @param image 图片
 */
- (void)rightButtonForImage:(UIImage *)image;

/**
 *  设置右侧按钮为文字按钮
 *
 *  @param title 文字
 */
- (void)rightButtonForText:(NSString *)title;

/**
 *  添加按钮
 *
 *  @param addButton 按钮
 */
- (void)addRightButton:(UIButton *)addButton;

/**
 *  移除按钮
 *
 *  @param button 按钮
 */
- (void)removeRightButton:(UIButton *)button;

@end
