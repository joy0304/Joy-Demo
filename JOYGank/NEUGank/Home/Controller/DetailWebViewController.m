//
//  DetailWebViewController.m
//  NEUGank
//
//  Created by Joy on 16/7/14.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "DetailWebViewController.h"
#import "NEUToolBar.h"
#import "MBProgressHUD.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NEUHomeDataManager.h"

@interface DetailWebViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation DetailWebViewController

- (instancetype)initWithModel:(HomeModel *)model {
    self = [super init];
    if (self) {
        self.detailURL = model.detailURL;
        self.descTitle = model.describe;
        self.pubName = model.userName;
        self.pubTime = model.publishTime;
    }
    return self;
}

-(void)loadView {
    [super loadView];
    
    [self.view addSubview:self.detailWebView];
    [self.detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
    }];
    
    [self.view addSubview:self.progressBar];
    [self.progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@3);
    }];
    
    [self.view addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"v2_star_no"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(NEUAPPWIDTH - 40, 0, 60, 40)];
    [button setImage:image forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareAction:(UIButton *)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        sender.selected = YES;
         UIImage *selectedImage = [UIImage imageNamed:@"v2_star_on"];
        [sender setImage:selectedImage forState:UIControlStateSelected];
    }
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"Favourite"];// 构建对象
    [todoFolder setObject:self.detailURL forKey:@"url"];// 设置url
    todoFolder[@"publishedTime"] = self.pubTime;
    todoFolder[@"publishedName"] = self.pubName;
    todoFolder[@"desc"] = self.descTitle;
    todoFolder[@"articleCategory"] = @"iOS";
    [todoFolder saveInBackground];// 保存到云端
    _HUD = [MBProgressHUD showHUDAddedTo:_detailWebView animated:YES];
    _HUD.label.text = @"收藏成功";
    [_HUD hideAnimated:YES afterDelay:1.0];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    [self.detailWebView removeObserver:self forKeyPath:@"webViewprogress"];
    
}

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"webViewprogress"]) {
        self.progressBar.hidden = self.detailWebView.estimatedProgress == 1;
        [self.progressBar setProgress:self.detailWebView.estimatedProgress animated:YES];
        if (self.detailWebView.estimatedProgress == 1.0) {
            self.progressBar.progress = 0.0;
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [MBProgressHUD hideHUDForView:_detailWebView animated:YES];
}
#pragma mark - getter and setter
- (WKWebView *)detailWebView {
    if (!_detailWebView) {
        _detailWebView = [[WKWebView alloc] init];
        [_detailWebView addObserver:self forKeyPath:@"webViewprogress" options:NSKeyValueObservingOptionNew context:nil];
        _detailWebView.navigationDelegate = self;
        _HUD = [MBProgressHUD showHUDAddedTo:_detailWebView animated:YES];
        [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailURL]]];

    }
    return _detailWebView;
}

-(UIProgressView *)progressBar {
    if (!_progressBar) {
        _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressBar.progressTintColor = [UIColor redColor];
        _progressBar.layer.zPosition = 99;
        
    }
    return _progressBar;
}

- (NEUToolBar *)toolBar {
    if (_toolBar) {
        _toolBar = [[NEUToolBar alloc] init];
    }
    return _toolBar;
}
@end
