//
//  DbCommonOperation.m
//  WorldTimer
//
//  Created by DongCai on 6/9/14.
//  Copyright (c) 2014 ___DanielStudio___. All rights reserved.
//

#import "BaseDBService.h"
#import "FMDB/FMDatabase.h"

@implementation BaseDBService
static BaseDBService* userDBSinglton;
+(BaseDBService *)getUserDBService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDBSinglton = [BaseDBService new];
        //        [userDBSinglton initUserDB];
    });
    return userDBSinglton;
}

static BaseDBService* commonDBSinglton;
+(BaseDBService *)getCommonDBService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonDBSinglton = [BaseDBService new];
    });
    return commonDBSinglton;
}

-(void)initUserDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"WorldTimer.db"]];
    NSLog(@"准备打开用户数据库文件:%@", dbPath);
    _db= [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"无法打开数据库");
        return;
    }
    NSLog(@"当前数据库版本%s", sqlite3_libversion());
    //以下是对表的检查和初始化
    [userDBSinglton checkTable:@"TimerSave" WithColumns:[NSArray arrayWithObjects:@"city", @"country", @"timezone", @"timerCode", nil] AndTypeArray:[NSArray arrayWithObjects:@"TEXT", @"TEXT", @"TEXT", @"TEXT", nil]];
}

-(void)closeUserDB
{
    if ([_db open]) {
        [_db close];
    }
}

-(void)initCommonDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"Infinitus_Local.db"];
    _db= [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"无法打开数据库");
        return;
    }
    NSLog(@"当前数据库版本%s", sqlite3_libversion());
    //检查表结构
    [commonDBSinglton checkTable:@"State" WithColumns:[NSArray arrayWithObjects:@"stateCode", @"stateName", @"lang", nil] AndTypeArray:[NSArray arrayWithObjects:@"TEXT", @"TEXT", @"TEXT", nil]];
    [commonDBSinglton checkTable:@"Province" WithColumns:[NSArray arrayWithObjects:@"provinceCode", @"provinceName", @"lang", @"stateCode",nil] AndTypeArray:[NSArray arrayWithObjects:@"TEXT", @"TEXT", @"TEXT", @"TEXT, FOREIGN KEY(stateCode) REFERENCES State(stateCode)", nil]];
    [commonDBSinglton checkTable:@"City" WithColumns:[NSArray arrayWithObjects:@"cityCode", @"cityName", @"lang", @"provinceCode", nil] AndTypeArray:[NSArray arrayWithObjects:@"TEXT", @"TEXT", @"TEXT", @"TEXT, FOREIGN KEY(provinceCode) REFERENCES Province(provinceCode)", nil]];
    [commonDBSinglton checkTable:@"Region" WithColumns:[NSArray arrayWithObjects:@"regionCode", @"regionName", @"lang", @"cityCode", nil] AndTypeArray:[NSArray arrayWithObjects:@"TEXT", @"TEXT", @"TEXT", @"TEXT, FOREIGN KEY(cityCode) REFERENCES City(cityCode)", nil]];
}

-(void)checkTable:(NSString *)tableName WithColumns:(NSArray *)columns AndTypeArray:(NSArray *)columnTypes;
{
    NSString *checkTableSQL = [NSString stringWithFormat:@"SELECT * FROM sqlite_master where type='table' and name='%@'",tableName];
    FMResultSet *checkTableRS = [_db executeQuery:checkTableSQL];
    NSString *selectedName;
    if ([checkTableRS next]) {
        selectedName = [checkTableRS stringForColumn:@"name"];
    }
    if (selectedName && selectedName!=(id)[NSNull null] && selectedName.length > 0) {
        //能选出表名说明表存在,开始检查列
        for (int i = 0; i < [columns count]; i++) {
            NSString *columName = [columns objectAtIndex:i];
            NSString *checkColumnsSQL = [NSString stringWithFormat:@"SELECT %@ FROM %@", columName, tableName];
            FMResultSet *checkColumnRS = [_db executeQuery:checkColumnsSQL];
            if (checkColumnRS.columnCount == 1) {//因为是按照类名去select,所以这里列数为1表示所select的类存在于表中
                //列正常
                continue;
            } else {
                NSLog(@"表%@中列%@不存在,错误代码%d,开始尝试创建.", tableName, columName, [_db lastErrorCode]);
                NSString *type;
                if (i < [columnTypes count]) {
                    type = [columnTypes objectAtIndex:i];
                } else {
                    type = @"TEXT";
                }
                NSString *alertColumnSQL = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@", tableName, columName, type];
                BOOL flag = [_db executeUpdate:alertColumnSQL];
                if (flag) {
                    NSLog(@"表%@增加列%@成功", tableName, columName);
                } else {
                    NSLog(@"表%@增加列%@失败", tableName, columName);
                }
            }
        }
    } else {
        //不能选出表名,说明表不存在
        NSLog(@"表%@不存在,开始尝试创建.", tableName);
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE %@ (", tableName];
        for (int i = 0; i < [columns count]; i++) {
            NSString *column = [columns objectAtIndex:i];
            NSString *type;
            if (i < [columnTypes count]) {
                type = [columnTypes objectAtIndex:i];
            } else {
                type = @"TEXT";
            }
            if (i > 0) {
                createSQL = [createSQL stringByAppendingString:@", "];
            }
            createSQL = [createSQL stringByAppendingFormat:@"%@ %@", column, type];
        }
        createSQL = [createSQL stringByAppendingString:@")"];
        BOOL flag = [_db executeUpdate:createSQL];
        if (flag) {
            NSLog(@"创建表%@成功", tableName);
        } else {
            NSLog(@"创建表%@失败,发生错误%@", tableName, [_db lastError]);
        }
    }
}

-(BOOL)executeUpdate:(NSString *)sql ArgumentArray:(NSArray *)array
{
#ifdef SHOW_SQL_FOR_DEBUG
    NSLog(@"执行SQL:%@", sql);
#endif
    return [_db executeUpdate:sql withArgumentsInArray:array];
}

-(FMResultSet *)executeQuery:(NSString *)sql ArgumentArray:(NSArray *)array
{
#ifdef SHOW_SQL_FOR_DEBUG
    NSLog(@"执行SQL:%@", sql);
#endif
    FMResultSet *rs = [_db executeQuery:sql withArgumentsInArray:array];
    if ([_db hadError]) {
        NSLog(@"在执行SQL:%@的时候发生错误%@", sql, [_db lastError]);
        return nil;
    } else {
        return rs;
    }
}
@end
