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

@interface ViewController ()<UIWebViewDelegate, CNNavigationBarDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBar.title = @"标121212题";
    self.navigationBar.isHiddenLeftButton = YES;
    self.navigationBar.delegate = self;
    
    [self.navigationBar rightButtonForText:@"GO"];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.contentScrollView];
    self.contentScrollView.delegate = self;
    self.contentScrollView.backgroundColor = [UIColor blueColor];
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width, self.contentView.bounds.size.height * 2.0);
    
    NSLog(@"self.contentView  %@", NSStringFromCGRect(self.contentView.frame));
    NSLog(@"self.contentScrollView  %@", NSStringFromCGRect(self.contentScrollView.frame));
    NSLog(@"self.contentScrollView  %@", NSStringFromCGPoint(self.contentScrollView.contentOffset));
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"self.contentScrollView 22222 %@", NSStringFromCGPoint(self.contentScrollView.contentOffset));
}

- (void)viewDidLayoutSubviews {
    self.contentScrollView.frame = self.contentView.bounds;
}

#pragma mark 右侧按钮点击事件
- (void)navigationBarRightButtonClick {
    SecondViewController *secVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 300) {
        [self hidenNavigationBar:YES];
    } else if (scrollView.contentOffset.y <= 0.0) {
        [self hidenNavigationBar:NO];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
