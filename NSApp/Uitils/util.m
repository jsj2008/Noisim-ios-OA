//
//  util.m
//  NSApp
//
//  Created by DongCai on 7/30/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "util.h"
#import "NSObject+propertyList.h"

//生成一个自定义的导航栏返回按钮
UIBarButtonItem *getCustomNavBackButton(id iTarget, SEL iSelector)
{
    //    UIButton *aCustomView = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [aCustomView setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //    aCustomView.frame = CGRectMake(0, 20, 43, 43);
    //    [aCustomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [aCustomView addTarget:iTarget action:iSelector forControlEvents:UIControlEventTouchUpInside];
    //    return [[UIBarButtonItem alloc] initWithCustomView:aCustomView];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 14, 22)];
    
    [backButton setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [backButton addTarget:iTarget action:iSelector forControlEvents:UIControlEventTouchUpInside];
    //将返回按钮向右偏移5像素，这样不会太贴边
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return item;
}

//生成一个自定义的导航栏按钮
UIBarButtonItem *getCustomNavButton(NSString *iTitle,id iTarget, SEL iSelector)
{
    UIButton *aCustomView = [UIButton buttonWithType:UIButtonTypeCustom];
    [aCustomView setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    CGSize size = [iTitle sizeWithFont:aCustomView.titleLabel.font];
    [[aCustomView titleLabel] setFont:[UIFont systemFontOfSize:16]];
    aCustomView.frame = CGRectMake(0, 0, size.width+15, 43);
    [aCustomView setTitle:iTitle forState:UIControlStateNormal];
    [aCustomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aCustomView setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [aCustomView addTarget:iTarget action:iSelector forControlEvents:UIControlEventTouchUpInside];
    [aCustomView.titleLabel setShadowOffset:CGSizeMake(0.0,1.0)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aCustomView];
    return barButton;
}

//根据传入的类型和字典创建一个简单的对象,属性仅支持基本类型
id getObjectFromDic(Class itemClass, NSDictionary *dic)
{
    id item = [[itemClass alloc]init];
    NSArray *properties = [item getPropertyList];
    for (NSString *propertyName in properties) {
        NSString *key = propertyName;
        if ([dic objectForKey:key] && [dic objectForKey:key]!=(id)[NSNull null]) {//对象存在且不为Null才进行赋值
            [item setValue:[dic objectForKey:key] forKey:propertyName];
        }
    }
    return item;
}
