//
//  BasicDbItem+DBOperationHelper.h
//  WorldTimer
//
//  Created by DongCai on 6/9/14.
//  Copyright (c) 2014 ___DanielStudio___. All rights reserved.
//

#import "BasicDbItem.h"

@interface BasicDbItem (DBOperationHelper)

//从数据库读取全部记录的方法
+(NSArray *)getAllFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass;
//根据传入的查询条件查询数据库对象
+(NSArray *)queryItemsInTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)condition Arguments:(NSArray *)arguments;
//从表中找到最大的key
+(NSInteger)selectMaxInTable:(NSString *)tableName Key:(NSString *)key;
//执行一个实例的保存操作,通过一个主键控制更新或者插入
-(BOOL)saveToDBToTable:(NSString *)tableName DataClass:(Class)itemClass KeyName:(NSString *)keyName;
//执行一个更新操作，根据传入的条件将当前对象保存到数据库中
-(bool)updateToTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)conditon Arguments:(NSArray *)arguments;
//执行一个插入操作,将当前对象保存到数据库中
-(BOOL)insertToTable:(NSString *)tableName DataClass:(Class)itemClass;
//执行一个实例的删除操作,通过一个主键执行删除
-(BOOL)deleteFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass KeyName:(NSString *)keyName;
//执行一个删除,通过传入的参数进行
+(BOOL)deleteFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)condition Arguments:(NSArray *)arguments;
@end
