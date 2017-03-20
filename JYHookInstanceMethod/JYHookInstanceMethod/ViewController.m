//
//  ViewController.m
//  JYHookInstanceMethod
//
//  Created by wangjiale on 2017/3/20.
//  Copyright © 2017年 wangjiale. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Hook.h"
#import "LDSubclass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    ViewController * vc = [[ViewController alloc] init];

    [vc eat];
    
    NSLog(@"-----------");
    
    ViewController * hookedInstance= [[ViewController alloc] init];
    
    [ViewController hookWithInstance:hookedInstance method:@selector(eat)];
    
    [hookedInstance eat];
}

- (void)eat {
    NSLog(@"original eat");
}
@end
