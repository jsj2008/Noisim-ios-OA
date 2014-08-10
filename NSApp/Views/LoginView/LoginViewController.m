//
//  LoginViewController.m
//  NSApp
//
//  Created by DongCai on 8/7/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        _userName_lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 150, 60, 30)];
        [_userName_lab setText:@"账号:"];
        [_userName_lab setFont:[UIFont systemFontOfSize:15]];
        [self.view addSubview:_userName_lab];
        _userName_tf = [[UITextField alloc]initWithFrame:CGRectMake(110, 150, 160, 30)];
        [_userName_tf setFont:[UIFont systemFontOfSize:15]];
        [_userName_tf setBorderStyle:UITextBorderStyleRoundedRect];
        [self.view addSubview:_userName_tf];
        _passWord_lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 190, 60, 30)];
        [_passWord_lab setText:@"密码:"];
        [_passWord_lab setFont:[UIFont systemFontOfSize:15]];
        [self.view addSubview:_passWord_lab];
        _passWord_tf = [[UITextField alloc]initWithFrame:CGRectMake(110, 190, 160, 30)];
        [_passWord_tf setFont:[UIFont systemFontOfSize:15]];
        [_passWord_tf setBorderStyle:UITextBorderStyleRoundedRect];
        _passWord_tf.secureTextEntry = YES; //密码
        [self.view addSubview:_passWord_tf];
        
        _login = [[UIButton alloc]initWithFrame:CGRectMake(220, 260, 50, 32)];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login setBackgroundColor:[UIColor grayColor]];
//        [_login setBounds:CGRectMake(2, 2, 26, 16)];
        [_login setEnabled:YES];
        [_login setShowsTouchWhenHighlighted:YES];
        [_login addTarget:self action:@selector(login:) forControlEvents:UIControlStateHighlighted];
        [self.view addSubview:_login];

        _userName_tf.delegate = self;
        _passWord_tf.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma keybord exit
-(void)dismissKeyboard {
    [_userName_tf resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma loginAction
-(void)login:(id)sender
{
    NSLog(@"login OA");
    NSLog(@"账号: %@  密码: %@",_userName_tf.text,_passWord_tf.text);
    _loginSer = [[LoginService alloc]init];
    _loginSer.userName = _userName_tf.text;
    _loginSer.passWord = _passWord_tf.text;
    [_loginSer login:@selector(finish:) fail:@selector(fail:) delegate:self];
}
-(void)finish:(id)data{
    NSLog(@"%@",data);
    _mainView= [[MainViewController alloc] init];
    [self.navigationController pushViewController:_mainView animated:YES];
//    [self presentModalViewController:_mainView animated:NO];
}
-(void)fail:(id)data{
    NSLog(@"%@",data);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
