//
//  BasicDbItem+DBOperationHelper.m
//  WorldTimer
//
//  Created by DongCai on 6/9/14.
//  Copyright (c) 2014 ___DanielStudio___. All rights reserved.
//

#import "BasicDbItem+DBOperationHelper.h"
#import "NSObject+propertyList.h"

@implementation BasicDbItem (DBOperationHelper)

+(NSArray *)getAllFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass
{
    //    NSMutableArray *result = [NSMutableArray array];
    //    NSArray *keyList = [[itemClass new] getPropertyList];
    //    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    //    FMResultSet *rs = [[BaseDBService getUserDBService] executeQuery:sql ArgumentArray:nil];
    //    if (rs) {
    //        while ([rs next]) {
    //            //开始获取数据
    //            id item = [itemClass new];
    //            for (NSString *key in keyList) {
    //                [item setValue:[rs objectForColumnName:key] forKey:key];
    //            }
    //            [result addObject:item];
    //        }
    //    }
    //    return result;
    return [BasicDbItem queryItemsInTable:tableName DataClass:itemClass Condition:nil Arguments:nil];
}

+(NSArray *)queryItemsInTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)condition Arguments:(NSArray *)arguments
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *keyList = [[itemClass new] getPropertyList];
    NSString *sql = nil;
    if (condition && condition.length > 0) {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", tableName, condition];
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    }
    FMResultSet *rs = [[BaseDBService getUserDBService] executeQuery:sql ArgumentArray:arguments];
    if (rs) {
        while ([rs next]) {
            //开始获取数据
            id item = [itemClass new];
            for (NSString *key in keyList) {
                [item setValue:[rs objectForColumnName:key] forKey:key];
            }
            [result addObject:item];
        }
    }
    return result;
}

+(NSInteger)selectMaxInTable:(NSString *)tableName Key:(NSString *)key
{
    NSString *sql = [NSString stringWithFormat:@"SELECT max(%@) FROM %@", key, tableName];
    FMResultSet *rs = [[BaseDBService getUserDBService] executeQuery:sql ArgumentArray:nil];
    NSInteger max = -1;
    if ([rs next]) {
        max = [rs intForColumnIndex:0];
    }
    return max;
}

-(BOOL)saveToDBToTable:(NSString *)tableName DataClass:(Class)itemClass KeyName:(NSString *)keyName
{
    //先搜索是否存在
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@ where %@=?", tableName, keyName];
    FMResultSet *rs = [[BaseDBService getUserDBService] executeQuery:selectSQL ArgumentArray:[NSArray arrayWithObject:[self valueForKey:keyName]]];
    BOOL existFlag = NO;
    if (rs && [rs next]) {
        existFlag = YES;
    }
    if (existFlag) {
        //已经存在,执行update操作
        NSString *condition = [NSString stringWithFormat:@"%@ = ?", keyName];
        NSArray *arguments = [NSArray arrayWithObject:[self valueForKey:keyName]];
        return [self updateToTable:tableName DataClass:itemClass Condition:condition Arguments:arguments];
    } else {
        //未有对象，执行insert操作
        return [self insertToTable:tableName DataClass:itemClass];
    }
}

-(bool)updateToTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)conditon Arguments:(NSArray *)arguments
{
    //执行update操作
    NSArray *keyList = [[itemClass new] getPropertyList];
    NSMutableArray *values = [NSMutableArray array];
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET ", tableName];
    for (int i = 0; i < [keyList count]; i++) {
        NSString *key = [keyList objectAtIndex:i];
        if ([self valueForKey:key] == nil) {
            NSLog(@"字段%@为空,尝试跳过", key);
            continue;
        }
        if (i>0) {
            updateSQL = [updateSQL stringByAppendingString:@", "];
        }
        updateSQL = [updateSQL stringByAppendingFormat:@"%@=?", key];
        [values addObject:[self valueForKey:key]];
    }
    updateSQL = [updateSQL stringByAppendingFormat:@" WHERE %@", conditon];
    [values addObjectsFromArray:arguments];
    BOOL updateFlag = [[BaseDBService getUserDBService] executeUpdate:updateSQL ArgumentArray:values];
    if (updateFlag) {
        NSLog(@"对象更新成功");
    } else {
        NSLog(@"对象更新失败");
    }
    return updateFlag;
}

-(BOOL)insertToTable:(NSString *)tableName DataClass:(Class)itemClass
{
    //执行insert操作
    NSArray *keyList = [[itemClass new] getPropertyList];
    NSMutableArray *arguments = [NSMutableArray array];
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO %@ (", tableName];
    NSString *values = @"VALUES (";
    for (int i = 0; i < [keyList count]; i++) {
        NSString *key = [keyList objectAtIndex:i];
        if ([self valueForKey:key] == nil) {
            NSLog(@"字段%@为空,尝试跳过", key);
            continue;
        }
        if (i>0) {
            insertSQL = [insertSQL stringByAppendingString:@", "];
            values = [values stringByAppendingString:@", "];
        }
        insertSQL = [insertSQL stringByAppendingFormat:@"%@", key];
        values = [values stringByAppendingString:@"?"];
        [arguments addObject:[self valueForKey:key]];
    }
    insertSQL = [insertSQL stringByAppendingFormat:@") %@)", values];
    BOOL insertFlag = [[BaseDBService getUserDBService] executeUpdate:insertSQL ArgumentArray:arguments];
    if (insertFlag) {
        NSLog(@"对象插入成功");
    } else {
        NSLog(@"对象插入失败");
    }
    return insertFlag;
}

-(BOOL)deleteFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass KeyName:(NSString *)keyName
{
    NSString *condition = [NSString stringWithFormat:@"%@ = ?", keyName];
    NSArray *arguments = [NSArray arrayWithObject:[self valueForKey:keyName]];
    return [BasicDbItem deleteFromDBInTable:tableName DataClass:itemClass Condition:condition Arguments:arguments];
}

+(BOOL)deleteFromDBInTable:(NSString *)tableName DataClass:(Class)itemClass Condition:(NSString *)condition Arguments:(NSArray *)arguments
{
    NSString *deleteSQL = nil;
    if (condition && condition.length>0) {
        deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", tableName, condition];
    } else {
        deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    }
    BOOL deleteFlag = [[BaseDBService getUserDBService] executeUpdate:deleteSQL ArgumentArray:arguments];
    if (deleteFlag) {
        NSLog(@"对象删除成功");
    } else {
        NSLog(@"对象删除失败");
    }
    return deleteFlag;
}
@end
