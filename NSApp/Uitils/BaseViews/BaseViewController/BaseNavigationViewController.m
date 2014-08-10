//
//  BaseNavigationViewController.m
//  NSApp
//
//  Created by DongCai on 8/10/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"88touming"] forBarMetrics:UIBarMetricsDefault];
        //        [self.navigationBar setTintColor:[UIColor colorWithRed:77.0/255.0 green:143.0/255.0 blue:12.0/255.0 alpha:1.0]];
        [self.navigationBar setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)popself

{
    [self popViewControllerAnimated:YES];
    
}

//-(UIBarButtonItem*) createBackButton
//
//{
//    UIButton *searchbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 23)];
//
//    [searchbutton setBackgroundImage:[UIImage imageNamed:@"back_nav.png"] forState:UIControlStateNormal];
//    [searchbutton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
//    return item;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
            viewController.navigationItem.leftBarButtonItem = getCustomNavBackButton(self, @selector(popself));
    }
//    if (self.viewControllers.count > 1) {
//        viewController.navigationItem.leftBarButtonItem = nil;
//        //如果被push的页面支持自定义返回方法，则讲返回按钮的方法指向页面，否则使用默认的方法
//        if ([viewController respondsToSelector:@selector(backMethod)]) {
//            viewController.navigationItem.leftBarButtonItem = getCustomNavBackButton(viewController, @selector(backMethod));
//        } else {
//            viewController.navigationItem.leftBarButtonItem = getCustomNavBackButton(self, @selector(popself));
//        }
//    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
