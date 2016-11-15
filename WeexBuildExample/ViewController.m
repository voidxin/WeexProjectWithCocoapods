//
//  ViewController.m
//  WeexDemo
//
//  Created by 张新 on 16/9/14.
//  Copyright © 2016年 voidxin. All rights reserved.
//
#import "ViewController.h"
#import <WeexSDK/WXSDKInstance.h>
#import "ImageDownloadder.h"
@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, assign) CGFloat weexHeight;
@property (nonatomic,strong) UIButton *testBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    
    //
    
    [self render];
    
}

- (void)dealloc
{
    [_instance destroyInstance];
}

- (void)render
{
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
   
    _instance.frame = CGRectMake(0,64,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 64);
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf.weexView);
    };
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"failed %@",error);
    };
    
    _instance.renderFinish = ^(UIView *view) {
        NSLog(@"render finish");
    };
    
    _instance.updateFinish = ^(UIView *view) {
        NSLog(@"update Finish");
    };
    NSString *url = [NSString stringWithFormat:@"file://%@/hehe.js",[NSBundle mainBundle].bundlePath];
    
    [_instance renderWithURL:[NSURL URLWithString:url] options:@{@"bundleUrl":url} data:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
