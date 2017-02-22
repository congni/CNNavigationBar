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
@synthesize titleType = _titleType;
@synthesize title = _title;
@synthesize titleLabelFont = _titleLabelFont;
@synthesize titleLabelColor = _titleLabelColor;
@synthesize detailTitle = _detailTitle;
@synthesize detailTitleLabelFont = _detailTitleLabelFont;
@synthesize detailTitleLableColor = _detailTitleLableColor;
@synthesize detailImage = _detailImage;
@synthesize detailTitleType = _detailTitleType;
@synthesize spaceForTitle = _spaceForTitle;
@synthesize spaceForLoadingImage = _spaceForLoadingImage;
@synthesize leftButtonTitleColor = _leftButtonTitleColor;
@synthesize leftButtonTitleFont = _leftButtonTitleFont;
@synthesize leftButtonIconImage = _leftButtonIconImage;
@synthesize leftButtonTitle = _leftButtonTitle;
@synthesize leftButtonStyle = _leftButtonStyle;
@synthesize isHiddenAllButton = _isHiddenAllButton;
@synthesize isHiddenLeftButton = _isHiddenLeftButton;
@synthesize isWebSite = _isWebSite;
@synthesize progress = _progress;


#pragma mark - LifeCycle
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
- (void)layoutSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize statueSize = [UIApplication sharedApplication].statusBarFrame.size;
    self.frame = CGRectMake(0, 0, screenSize.width, [self navigationBarStatueHeight]);
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
    
    titleLabelWidth = _titleLabel.frame.size.width;
    titleLabelPositionX = (screenSize.width - titleLabelWidth) / 2.0;
    float titleLabelPositionY = (self.navigationBarHeight - _titleLabel.frame.size.height) / 2.0 + statueSize.height;
    [_titleLabel labelWithText:self.title image:self.titleImage];
    
    if (self.detailTitleType != CNNavigationBarDetailTitleTypeNone) {
        titleLabelPositionY = statueSize.height;
        [_detailLable sizeToFit];
        float frontWidth = 0.0;
        float frontX = 0.0;
        float detailWidth = _detailLable.frame.size.width;
        float detailHeight = _detailLable.frame.size.height;
        float detailLabelX = (screenSize.width - detailWidth) / 2.0;
        float detailLabelY = _titleLabel.frame.size.height + titleLabelPositionY;
        float totalTitleHeight = _titleLabel.frame.size.height + self.spaceForTitle + detailHeight;
        titleLabelPositionY = (self.navigationBarHeight - totalTitleHeight) / 2.0 + statueSize.height;
        detailLabelY = titleLabelPositionY + _titleLabel.frame.size.height + self.spaceForTitle;
        
        if (self.detailTitleType == CNNavigationBarDetailTitleTypeImage) {
            frontWidth = self.detailImage.size.width;
            detailWidth = frontWidth + self.spaceForLoadingImage + detailWidth;
            frontX = (screenSize.width - detailWidth) / 2.0;
            detailLabelX = frontX + frontWidth + self.spaceForLoadingImage;
            
            _detailImageView.frame = CGRectMake(frontX, detailLabelY, frontWidth, self.detailImage.size.height);
        } else if (self.detailTitleType == CNNavigationBarDetailTitleTypeLoading) {
            frontWidth = _detailLable.frame.size.height;
            detailWidth = frontWidth + self.spaceForLoadingImage + detailWidth;
            frontX = (screenSize.width - detailWidth) / 2.0;
            detailLabelX = frontX + frontWidth + self.spaceForLoadingImage;
            
            _detailLoading.frame = CGRectMake(frontX, detailLabelY, _detailLable.frame.size.height, _detailLable.frame.size.height);
        }
        
        _detailLable.frame = CGRectMake(detailLabelX, detailLabelY, detailWidth, detailHeight);
    }
    
    _titleLabel.frame =CGRectMake(titleLabelPositionX, titleLabelPositionY, titleLabelWidth, _titleLabel.frame.size.height);
    
    if (self.isWebSite && _progressView) {
         _progressView.frame = CGRectMake(0, self.frame.size.height - 1.0, self.frame.size.width, 0.1);
        _progressView.progressTintColor = self.progressColor;
    }
    
    if (self.isWebSite && _closeButton && self.isShowCloseButton) {
        _closeButton.titleLabel.font = self.closeButtonTitleFont;
        [_closeButton setTitleColor:self.closeButtonTitleColor forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        float closeButtonPositionY = (self.navigationBarHeight - _closeButton.frame.size.height) / 2.0 + statueSize.height;
        
        _closeButton.frame = CGRectMake(_leftIconLabel.frame.origin.x + _leftIconLabel.frame.size.width + self.spaceOffset.vertical, closeButtonPositionY, _closeButton.frame.size.width, _closeButton.frame.size.height);
    }
}

#pragma mark - Private Method
#pragma mark 初始化设置
- (void)initData {
    self.titleType = CNNavigationBarTitleTypeNormal;
    self.title = @"标题";
    self.titleLabelFont = [UIFont systemFontOfSize:12.0];
    self.titleLabelColor = [UIColor whiteColor];
    
    self.detailTitleType = CNNavigationBarDetailTitleTypeNone;
    self.detailTitleLableColor = [UIColor whiteColor];
    self.detailTitleLabelFont = [UIFont systemFontOfSize:10.0];
    self.spaceForTitle = 5.0;
    self.spaceForLoadingImage = 5.0;
    
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
    [self layoutSize];
}

#pragma mark 创建UI
- (void)createUI {
    _titleLabel = [[CNIconLabel alloc] init];
    _titleLabel.textPositionAdjustmentOffset = UIOffsetMake(0.0, 4.0);
    _titleLabel.iconStyle = IconPositionStyle_Right;
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

#pragma mark - Public Method
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
    
    [self layoutSize];
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
    
    [self layoutSize];
}

#pragma mark 添加按钮
- (void)addRightButton:(UIButton *)addButton {
    [_rightButtonsMulArray addObject:addButton];
    [self layoutSize];
}

#pragma mark 移除按钮
- (void)removeRightButton:(UIButton *)button {
    if ([_rightButtonsMulArray containsObject:button]) {
        [_rightButtonsMulArray removeObject:button];
    }
    
    [self layoutSize];
}

#pragma mark 关闭按钮点击
- (void)webSiteClose {
    if ([self.delegate respondsToSelector:@selector(navigationBarCloseButtonClick)]) {
        [self.delegate navigationBarCloseButtonClick];
    }
}

#pragma mark 标题点击
- (void)navigationBarTitleClick {
    if ([self.delegate respondsToSelector:@selector(navigationBarTitleClick)]) {
        [self.delegate navigationBarTitleClick];
    }
}

#pragma mark - GET/SET
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
    
    [self layoutSize];
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

- (void)setTitleType:(CNNavigationBarTitleType)titleType {
    _titleType = titleType;
    
    if (titleType == CNNavigationBarTitleTypeNormal) {
        
    } else if (titleType == CNNavigationBarTitleTypeEnableClick) {
        
    }
    
    switch (titleType) {
        case CNNavigationBarTitleTypeNormal:
            [_titleLabel removeTarget:self action:@selector(navigationBarTitleClick) forControlEvents:UIControlEventTouchUpInside];
            break;
        case CNNavigationBarTitleTypeEnableClick:
            [_titleLabel addTarget:self action:@selector(navigationBarTitleClick) forControlEvents:UIControlEventTouchUpInside];
            break;
        case CNNavigationBarTitleTypeEnableImageLeft:
            _titleLabel.iconStyle = IconPositionStyle_Left;
            
            [_titleLabel addTarget:self action:@selector(navigationBarTitleClick) forControlEvents:UIControlEventTouchUpInside];
            break;
        case CNNavigationBarTitleTypeEnableImageRight:
            _titleLabel.iconStyle = IconPositionStyle_Right;
            
            [_titleLabel addTarget:self action:@selector(navigationBarTitleClick) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [_titleLabel updateText:title];
    [self layoutSize];
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    
    _titleLabel.textLabelFont = titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    
    _titleLabel.textLabelColor = titleLabelColor;
}

- (void)setDetailTitle:(NSString *)detailTitle {
    _detailTitle = detailTitle;
    
    _detailLable.text = detailTitle;
    [self layoutSize];
}

- (void)setDetailTitleLabelFont:(UIFont *)detailTitleLabelFont {
    _detailTitleLabelFont = detailTitleLabelFont;
    
    _detailLable.font = detailTitleLabelFont;
}

- (void)setDetailTitleLableColor:(UIColor *)detailTitleLableColor {
    _detailTitleLableColor = detailTitleLableColor;
    
    _detailLable.textColor = detailTitleLableColor;
}

- (void)setDetailTitleType:(CNNavigationBarDetailTitleType)detailTitleType {
    _detailTitleType = detailTitleType;
    
    if (detailTitleType == CNNavigationBarDetailTitleTypeNone) {
        [_detailLoading stopAnimating];
        [_detailLoading removeFromSuperview];
        [_detailImageView removeFromSuperview];
        [_detailLable removeFromSuperview];
        
        _detailLoading = nil;
        _detailImageView = nil;
        _detailLable = nil;
    } else if (detailTitleType == CNNavigationBarDetailTitleTypeImage) {
        if (!_detailImageView) {
            _detailImageView = [[UIImageView alloc] init];
            _detailImageView.image = self.detailImage;
            [self addSubview:_detailImageView];
        }
    } else if (detailTitleType == CNNavigationBarDetailTitleTypeLoading) {
        if (!_detailLoading) {
            _detailLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            _detailLoading.transform = CGAffineTransformMakeScale(0.6, 0.6) ;
            [_detailLoading startAnimating];
            [self addSubview: _detailLoading];
        }
    }
    
    if (detailTitleType != CNNavigationBarDetailTitleTypeNone) {
        if (!_detailLable) {
            _detailLable = [[UILabel alloc] init];
            _detailLable.font = self.detailTitleLabelFont;
            _detailLable.textColor = self.detailTitleLableColor;
            [self addSubview: _detailLable];
        }
    }
    
    [self layoutSize];
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
