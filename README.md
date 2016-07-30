# CNNavigationBar
`自定义NavigationBar`,在介绍之前，先来看看效果图:

![预览图片1](1.png =400x)	![预览图片1](2.png =400x)

### CNNavigationBar
自定义的NavigationBar，其包含的功能用 
 
1. 支持左右侧按钮；
2. 左侧按钮(也可称返回按钮)，图片、文字可自定义设置，同时支持两种类型
3. 右侧按钮采用数组化管理，方便加入；
4. 支持网页加载模式: 关闭按钮、进度条等；
5. UI可高度定制化；
6. 代理回调；

### CNBaseViewController
基础的ViewController，内部已经默认做好一些bar的设置(当然你也可以自己设置)和容器的创建，继承他创建ViewController，可以省去一部分重复性代码，其特性包括：

1. 内部已对Bar和UI容器做了一定的创建设置，可以帮助您省去一部分重复性代码；
2. 支持全局性的Bar设置，可以方便管理Bar的UI样式，可以轻松实现换肤等功能；

### 集成
1. 手动集成。下载源码放到您的工程里面。`注：因组件引用第三方CNIconLabel库，所以手动集成，还需要集成CNIconLabel库.`[CNIconLabel](https://github.com/congni/CNIconLabel-OC)
2. Cocoapods集成。

注： 源码Demo里面，pods集成了[NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress)，主要用于网页模式下的进度条，如果您有网页模式，你可以在pod的中集成，如果没有则可忽视。

### 使用
##### 要想使用自定义的CNNavigationBar，前提是，`隐藏NavigationBar`:

	navigationVC.navigationBarHidden = YES;

##### 全局设置CNNavigationBar:

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
	//warning 全局Bar设置，当然你可以不设置，使用全局设置，可以方便的管理bar的UI样式等，可以轻松实现换肤等功能
	    NSDictionary *barSettingDictionary = @{kCNNavigationBarTitleFont: [UIFont systemFontOfSize:18.0],
	                                           kCNNavigationBarTitleColor: [UIColor whiteColor],
	                                           kCNNavigationBarLeftTitleFont: [UIFont systemFontOfSize:14.0],
	                                           kCNNavigationBarLeftTitleColor: [UIColor whiteColor],
	                                           kCNNavigationBarLeftIconImage: [UIImage imageNamed:@"image.bundle/NavigationBarImage_back_icon"],
	                                           kCNNavigationBarBackgroundColor: [UIColor greenColor]};
	    // 全局设置
	    [CNBaseViewController globalSettingNavigationBar:barSettingDictionary];
	    
	    ViewController *vc = [[ViewController alloc] init];
	    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
	    /**
	     *  隐藏系统自带的Bar
	     */
	    navigationVC.navigationBarHidden = YES;
	    
	    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	    self.window.rootViewController = navigationVC;
	    self.window.backgroundColor = [UIColor whiteColor];
	    [self.window makeKeyAndVisible];
	    
	    return YES;
	}


##### 继承CNBaseViewController，然后做相应的设置(如果您需要的话):

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

##### 当然，如果您不继承CNBaseViewController的话，你可以直接将CNNavigationBar加入到您的ViewController里面:

	self.navigationBar = [[CNNavigationBar alloc] init];
	// 根据需要设置一些参数
	self.navigationBar.title = @"标题";
    self.navigationBar.titleLabelFont      = [UIFont systemFontOfSize:18.0];
    self.navigationBar.leftButtonTitleFont = [UIFont systemFontOfSize:14.0];
    self.navigationBar.backgroundColor     = [UIColor redColor];
    self.navigationBar.rightButtonFont     = [UIFont systemFontOfSize:14.0];
	[self.view addSubview:self.navigationBar];
	
	
##### 右侧按钮添加

    // CNNavigationBar 默认支持右侧一个按钮，您可以通过其api调用
    [self.navigationBar rightButtonForText:@"GO"];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"刷新" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    
    // 如果右侧一个按钮无法满足您的需求，您可以通过这种方式添加右侧按钮，顺序，自己调一下就OK了
    [self.navigationBar addRightButton:cancelButton];

##### 回调事件

	#pragma mark 左侧按钮点击事件
	- (void)navigationBarLeftButtonClick {
	    [self.wbView goBack];
	}
	
	#pragma mark 关闭按钮点击事件
	- (void)navigationBarCloseButtonClick {
	    [self.navigationController popViewControllerAnimated:YES];
	}
	
	#pragma mark 右侧按钮点击事件
	- (void)navigationBarRightButtonClick {
	    SecondViewController *secVC = [[SecondViewController alloc] init];
	    [self.navigationController pushViewController:secVC animated:YES];
	}
	
 详细使用方式，可参看源码Demo，`如有问题，欢迎指正。`