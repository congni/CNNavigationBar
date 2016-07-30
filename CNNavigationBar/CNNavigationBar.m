//
//  CNNavigationBar.m
//  MakeupLessons
//
//  Created by 葱泥 on 16/6/13.
//  Copyright © 2016年 quanXiang. All rights reserved.
//

#import "CNNavigationBar.h"
#import "CNIconLabel.h"


@implementation CNNavigationBar
@synthesize title = _title;
@synthesize titleLabelFont = _titleLabelFont;
@synthesize titleLabelColor = _titleLabelColor;
@synthesize leftButtonTitleColor = _leftButtonTitleColor;
@synthesize leftButtonTitleFont = _leftButtonTitleFont;
@synthesize leftButtonIconImage = _leftButtonIconImage;
@synthesize leftButtonTitle = _leftButtonTitle;
@synthesize leftButtonStyle = _leftButtonStyle;
@synthesize isHiddenAllButton = _isHiddenAllButton;
@synthesize isHiddenLeftButton = _isHiddenLeftButton;
@synthesize isWebSite = _isWebSite;
@synthesize progress = _progress;


#pragma mark -LifeCycle
#pragma mark 初始化initWithFrame
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
        [self initData];
    }
    
    return self;
}

#pragma mark 初始化init
-(instancetype)init {
    self = [super init];
    
    if (self) {
        [self createUI];
        [self initData];
    }
    
    return self;
}

#pragma mark layoutSubviews
- (void)layoutSubviews {
    [_titleLabel sizeToFit];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize statueSize = [UIApplication sharedApplication].statusBarFrame.size;
    float titleLabelPositionX = self.spaceOffset.vertical;
    float titleLabelWidth = screenSize.width - titleLabelPositionX * 2;
    float contentViewWidth = self.spaceOffset.vertical;
    
    if (_leftIconLabel && !self.isHiddenLeftButton) {
        CGSize leftButtonSize = _leftIconLabel.frame.size;
        float leftButtonPositionY = (self.navigationBarHeight - leftButtonSize.height) / 2.0 + statueSize.height;
        titleLabelPositionX = _leftIconLabel.frame.origin.x + _leftIconLabel.frame.size.width + self.spaceOffset.vertical;
        
        _leftIconLabel.frame = CGRectMake(self.spaceOffset.vertical, leftButtonPositionY, _leftIconLabel.frame.size.width, _leftIconLabel.frame.size.height);
    }
    
    [self createOrClearRightButtonView];
    
    if (_rightButtonsMulArray.count > 0) {
        for (UIButton *button in _rightButtonsMulArray) {
            button.frame = CGRectMake(contentViewWidth, (self.navigationBarHeight - button.frame.size.height) / 2.0, button.frame.size.width, button.frame.size.height);
            
            contentViewWidth += (button.frame.size.width + self.spaceOffset.vertical);
            
            [_rightButtonView addSubview:button];
        }
        
        _rightButtonView.frame = CGRectMake(screenSize.width - contentViewWidth, statueSize.height, contentViewWidth, self.navigationBarHeight);
    } else {
        contentViewWidth = titleLabelPositionX;
    }
    
    titleLabelPositionX = _rightButtonView.frame.size.width > titleLabelPositionX ? _rightButtonView.frame.size.width : titleLabelPositionX;
    float titleLabelPositionY = (self.navigationBarHeight - _titleLabel.frame.size.height) / 2.0 + statueSize.height;
    titleLabelWidth = screenSize.width - titleLabelPositionX - contentViewWidth;
    
    _titleLabel.frame =CGRectMake(titleLabelPositionX, titleLabelPositionY, titleLabelWidth, _titleLabel.frame.size.height);
    self.frame = CGRectMake(0, 0, screenSize.width, [self navigationBarStatueHeight]);
    
    if (self.isWebSite && _progressView) {
         _progressView.frame = CGRectMake(0, self.frame.size.height - 1.0, self.frame.size.width, 0.1);
        _progressView.progressTintColor = self.progressColor;
    }
    
    if (self.isWebSite && _closeButton && self.isShowCloseButton) {
        float closeButtonPositionY = (self.navigationBarHeight - _closeButton.frame.size.height) / 2.0 + statueSize.height;
        _closeButton.titleLabel.font = self.closeButtonTitleFont;
        [_closeButton setTitleColor:self.closeButtonTitleColor forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        
        _closeButton.frame = CGRectMake(_leftIconLabel.frame.origin.x + _leftIconLabel.frame.size.width + self.spaceOffset.vertical, closeButtonPositionY, _closeButton.frame.size.width, _closeButton.frame.size.height);
    }
}

#pragma mark -Private Method
#pragma mark 初始化设置
- (void)initData {
    self.title = @"标题";
    self.titleLabelFont = [UIFont systemFontOfSize:12.0];
    self.titleLabelColor = [UIColor whiteColor];
    
    self.leftButtonTitleColor = [UIColor whiteColor];
    self.leftButtonTitleFont = [UIFont systemFontOfSize:12.0];
    self.leftButtonStyle = LeftButtonStyle_AllWithText;
    self.leftButtonIconImage = [UIImage imageNamed:@"Image.bundle/NavigationBarImage_back_icon"];
    self.leftButtonTitle = @"返回";
    
    self.progressColor = [UIColor blackColor];
    self.closeButtonTitleFont = [UIFont systemFontOfSize:14.0];
    self.closeButtonTitleColor = [UIColor whiteColor];
    self.isShowCloseButton = YES;
    
    self.isHiddenAllButton = self.isHiddenLeftButton = NO;
    
    self.rightButtonFont = [UIFont systemFontOfSize:12.0];
    self.rightButtonTitleColor = [UIColor whiteColor];
    
    self.spaceOffset = UIOffsetMake(10.0, 10.0);
    
    _rightButtonsMulArray = [[NSMutableArray alloc] init];
    self.navigationBarHeight = 49.0;
}

#pragma mark 创建UI
- (void)createUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = self.titleLabelColor;
    _titleLabel.font = self.titleLabelFont;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

#pragma mark 创建/清空 _rightButtonView
- (void)createOrClearRightButtonView {
    if (_rightButtonsMulArray.count > 0) {
        if (!_rightButtonView) {
            _rightButtonView = [[UIView alloc] init];
            [self addSubview:_rightButtonView];
        } else {
            while (_rightButtonView.subviews.count > 0) {
                UIButton *subButton = [_rightButtonView.subviews objectAtIndex:0];
                [subButton removeFromSuperview];
            }
        }
    } else if (_rightButtonView) {
        [_rightButtonView removeFromSuperview];
        _rightButtonView = nil;
    }
}

#pragma mark 创建左侧按钮
- (void)createLeftButton {
    if (!_leftIconLabel) {
        _leftIconLabel = [[CNIconLabel alloc] init];
        _leftIconLabel.iconStyle = IconPositionStyle_Left;
        _leftIconLabel.textLabelFont = self.leftButtonTitleFont;
        _leftIconLabel.textLabelColor = self.leftButtonTitleColor;
        [self addSubview:_leftIconLabel];
        [_leftIconLabel addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 更新左侧按钮
- (void)leftButtonStyleChange {
    switch (self.leftButtonStyle) {
        case LeftButtonStyle_AllWithText:
            [_leftIconLabel labelWithText:self.leftButtonTitle image:self.leftButtonIconImage];
            break;
        case LeftButtonStyle_AllWithOutText:
            [_leftIconLabel labelWithText:nil image:self.leftButtonIconImage];
            break;
            
        default:
            break;
    }
}

#pragma mark 左侧按钮点击
- (void)leftButtonClick {
    if ([self.delegate respondsToSelector:@selector(navigationBarLeftButtonClick)]) {
        [self.delegate navigationBarLeftButtonClick];
    }
}

#pragma mark 右侧按钮点击
- (void)rightButtonClick {
    if ([self.delegate respondsToSelector:@selector(navigationBarRightButtonClick)]) {
        [self.delegate navigationBarRightButtonClick];
    }
}

#pragma mark -Public Method
#pragma mark bar高度
- (float)navigationBarStatueHeight {
    CGSize statueSize = [UIApplication sharedApplication].statusBarFrame.size;
    return self.navigationBarHeight + statueSize.height;
}

#pragma mark 设置右侧按钮为图片按钮
- (void)rightButtonForImage:(UIImage *)image {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundImage:image forState:UIControlStateNormal];
        _rightButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_rightButtonsMulArray addObject:_rightButton];
    
    [self layoutSubviews];
}

#pragma mark 设置右侧按钮为文字按钮
- (void)rightButtonForText:(NSString *)title {
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.rightButtonFont} context:nil].size;
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:title forState:UIControlStateNormal];
        [_rightButton setTitleColor:self.rightButtonTitleColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = self.rightButtonFont;
        _rightButton.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_rightButtonsMulArray addObject:_rightButton];
    
    [self layoutSubviews];
}

#pragma mark 添加按钮
- (void)addRightButton:(UIButton *)addButton {
    [_rightButtonsMulArray addObject:addButton];
    [self layoutSubviews];
}

#pragma mark 移除按钮
- (void)removeRightButton:(UIButton *)button {
    if ([_rightButtonsMulArray containsObject:button]) {
        [_rightButtonsMulArray removeObject:button];
    }
    
    [self layoutSubviews];
}

#pragma mark 关闭按钮点击
- (void)webSiteClose {
    if ([self.delegate respondsToSelector:@selector(navigationBarCloseButtonClick)]) {
        [self.delegate navigationBarCloseButtonClick];
    }
}

#pragma mark -GET/SET
- (void)setIsWebSite:(BOOL)isWebSite {
    _isWebSite = isWebSite;
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    _progressView.progress = 0.5;
    [self addSubview:_progressView];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeButton sizeToFit];
    [self addSubview:_closeButton];
    [_closeButton addTarget:self action:@selector(webSiteClose) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)isWebSite {
    return _isWebSite;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    
    if (self.isWebSite && _progressView) {
        _progressView.progress = progress;
        
        if (progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progress = 0.0;
                _progressView.progress = 0.0;
            });
        }
    }
}

- (float)progress {
    return _progress;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = title;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    
    _titleLabel.font = titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    
    _titleLabel.textColor = titleLabelColor;
}

- (void)setLeftButtonIconImage:(UIImage *)leftButtonIconImage {
    _leftButtonIconImage = leftButtonIconImage;
    
    [self leftButtonStyleChange];
}

- (void)setLeftButtonStyle:(LeftButtonStyle)leftButtonStyle {
    _leftButtonStyle = leftButtonStyle;
    
    [self leftButtonStyleChange];
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    
    [self leftButtonStyleChange];
}

- (void)setLeftButtonTitleColor:(UIColor *)leftButtonTitleColor {
    _leftButtonTitleColor = leftButtonTitleColor;
    
    _leftIconLabel.textLabelColor = leftButtonTitleColor;
}

- (void)setLeftButtonTitleFont:(UIFont *)leftButtonTitleFont {
    _leftButtonTitleFont = leftButtonTitleFont;
    
    _leftIconLabel.textLabelFont = leftButtonTitleFont;
}

- (void)setIsHiddenAllButton:(BOOL)isHiddenAllButton {
    _isHiddenAllButton = isHiddenAllButton;
    
    if (isHiddenAllButton) {
        [_leftIconLabel removeFromSuperview];
        _leftIconLabel = nil;
        
        [_rightButton removeFromSuperview];
        _rightButton = nil;
    } else {
        [self createLeftButton];
    }
}

- (void)setIsHiddenLeftButton:(BOOL)isHiddenLeftButton {
    _isHiddenLeftButton = isHiddenLeftButton;
    
    if (isHiddenLeftButton) {
        [_leftIconLabel removeFromSuperview];
        _leftIconLabel = nil;
    } else {
        [self createLeftButton];
    }
}

@end
