//
//  DbCommonOperation.h
//  WorldTimer
//
//  Created by DongCai on 6/9/14.
//  Copyright (c) 2014 ___DanielStudio___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB/FMDatabase.h"

@interface BaseDBService : NSObject

@property (strong, nonatomic) FMDatabase *db;
//获取用户的数据库
+(BaseDBService *)getUserDBService;
//获取通用的数据库
+(BaseDBService *)getCommonDBService;

/**
 *	@brief	初始化数据库
 */
-(void)initUserDB;
-(void)closeUserDB;
-(void)initCommonDB;

/**
 *	@brief	执行insert update delete的SQL
 *
 *	@param 	sql 	SQL语句
 *	@param 	array 	参数列表
 *
 *  @return 执行成功与否
 */
-(BOOL)executeUpdate:(NSString *)sql ArgumentArray:(NSArray *)array;

/**
 *	@brief	执行select的SQL
 *
 *	@param 	sql 	SQL语句
 *	@param 	array 	参数列表
 *
 *	@return	结果集
 */
-(FMResultSet *)executeQuery:(NSString *)sql ArgumentArray:(NSArray *)array;
@end
