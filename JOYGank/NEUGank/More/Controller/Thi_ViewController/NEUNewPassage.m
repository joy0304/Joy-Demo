//
//  NEUNewPassage.m
//  NEUGank
//
//  Created by 周鑫城 on 8/12/16.
//  Copyright © 2016 Joy. All rights reserved.
//

#import "NEUNewPassage.h"
#import "NEUTextView.h"
#import "NEUCover.h"
#import "NEUTopTool.h"
#import "UIView+NEUExtension.h"

@interface NEUNewPassage () <NEUReleaseDelegate>

@property (nonatomic, weak) NEUTextView *textView;//内容输入框
@property (nonatomic, weak) NEUTextView *titleView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UILabel *textCount;

@end

@implementation NEUNewPassage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTopView];
    [self setupTitleTextView];
    
}
#pragma mark - 添加顶部工具条
-(void)setupTopView {
    NEUTopTool *tool = [[NEUTopTool alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    [tool setUpTopView];
    tool.delegate = self;
    [self.view addSubview:tool];
    tool.releaseOnClick = ^{
        if ([self.delegate respondsToSelector:@selector(releaser:title:text:)]) {
            [self.delegate releaser:self title:self.titleView.text text:self.textView.text];
            NSLog(@"hello i am public the new passage! A A A A ");
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)NEUTopToolOutLoginBtnClick {
    [self outLoginBtnClick];
}

#pragma mark - 点击了退出按钮
-(void)outLoginBtnClick {
    //弹出取消对话框
    NEUCover *cover = [NEUCover show];
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-150 , [UIScreen mainScreen].bounds.size.width, 150);
    self.bottomView = bottomView;
    [cover addSubview:bottomView];
    //添加放弃编辑按钮
    UIButton *quitBtn = [self addOneButtonWithName:@"放弃编辑" color:[UIColor redColor]];
    quitBtn.center = CGPointMake(bottomView.width * 0.5, 75);
    [quitBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:quitBtn];
    //添加取消按钮
    UIButton *cancelBtn = [self addOneButtonWithName:@"取消" color:[UIColor lightGrayColor]];
    cancelBtn.center = CGPointMake(bottomView.width * 0.5, 125);
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
}

#pragma mark - 取消
-(void)cancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 150);
    } completion:^(BOOL finished) {
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[NEUCover class]]) {
                [view removeFromSuperview];
                [self.bottomView removeFromSuperview];
            }
        }
    }];
    
}

#pragma mark -  放弃编辑
-(void)quit {
    //清楚弹窗
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 150);
    }completion:^(BOOL finished) {
        [self.bottomView removeFromSuperview];
    }];
    
    //添加弹窗
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"放弃编辑后,本次编辑的内容将会丢失,确定放弃?" preferredStyle:UIAlertControllerStyleAlert];
    //取消
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[NEUCover class]]) {
                [view removeFromSuperview];
            }
        }
    }];
    
    //确定放弃编辑
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[NEUCover class]]) {
                [view removeFromSuperview];
                [self.bottomView removeFromSuperview];
            }
        }
    }];
    //显示到窗口
    [alert addAction:action];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 添加一个按钮
-(UIButton *)addOneButtonWithName:(NSString *)name color:(UIColor *)color {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    CGRect frame = btn.frame;
    frame.size = CGSizeMake(80, 80);
    btn.frame = frame;
    return btn;
}


#pragma mark - 添加标题输入框
-(void)setupTitleTextView {
    //设置标题输入框
    NEUTextView *titleView = [[NEUTextView alloc] initWithFrame:CGRectMake(5, 64, [UIScreen mainScreen].bounds.size.width - 10, 40)];
    titleView.placeholder = @"请输入标题";
    titleView.font = [UIFont systemFontOfSize:(20.0f)];
    titleView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //添加分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(titleView.frame), [UIScreen mainScreen].bounds.size.width - 10, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    //设置内容输入框
    NEUTextView *textView = [[NEUTextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(line.frame), [UIScreen mainScreen].bounds.size.width - 10, [UIScreen mainScreen].bounds.size.height)];
    textView.placeholder = @"请输入正文";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}
//接收通知更改字数
-(void)textChange
{
    self.textCount.text = [NSString stringWithFormat:@"%ld字",self.textView.text.length];
}

#pragma mark -- public new passage 

-(void)releaser:(NEUNewPassage *)release title:(NSString *)title text:(NSString *)text {
    NSLog(@"hello i am public the new passage!");
}


@end
