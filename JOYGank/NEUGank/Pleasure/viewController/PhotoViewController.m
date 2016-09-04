//
//  PhotoViewController.m
//  NEUGank
//
//  Created by 中软mac004 on 16/7/22.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "PhotoViewController.h"
#import "photoView.h"
@interface PhotoViewController ()
@property (nonatomic, strong)photoView* photoview;

@end

@implementation PhotoViewController



//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)loadView {
    [super loadView];
    self.photoview = [[photoView alloc]initWithName:self.imageName];
    self.photoview.center = self.view.center;
    [self.view addSubview:self.photoview];
}
@end
