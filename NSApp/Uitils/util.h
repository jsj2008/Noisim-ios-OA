//
//  util.h
//  NSApp
//
//  Created by DongCai on 7/30/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>


//获取自定义的返回按钮
UIBarButtonItem *getCustomNavBackButton(id iTarget, SEL iSelector);
//获取一个自定义的导航栏按钮
UIBarButtonItem *getCustomNavButton(NSString *iTitle,id iTarget, SEL iSelector);

id getObjectFromDic(Class itemClass, NSDictionary *dic);