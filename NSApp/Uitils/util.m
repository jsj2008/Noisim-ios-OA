//
//  util.m
//  NSApp
//
//  Created by DongCai on 7/30/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "util.h"
#import "NSObject+propertyList.h"

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
