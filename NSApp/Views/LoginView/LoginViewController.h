//
//  LoginViewController.h
//  NSApp
//
//  Created by DongCai on 8/7/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BootViewController.h"

@class LoginService;
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    id delegate;
}

@property (retain, nonatomic)UILabel *userName_lab;
@property (retain, nonatomic)UILabel *passWord_lab;
@property (retain, nonatomic)UITextField *userName_tf;
@property (retain, nonatomic)UITextField *passWord_tf;
@property (retain, nonatomic)UIButton *login;
@property (strong, nonatomic)LoginService *loginSer;
@property (strong, nonatomic)NSMutableDictionary *loginInfo;

@property (strong, nonatomic)BootViewController *appView;


-(IBAction)login:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (void)textFiledReturnEditing:(id)sender;
@end
