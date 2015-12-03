//
//  PYTable.h
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYFMDB.h"
#import "PYStructure.h"
@interface PYTable : NSObject
@property (nonatomic,copy) PYFMDB * db;
/**
 *  数据表 表名
 */
@property(nonatomic,strong)NSString *tableName;

@property(nonatomic,strong)NSString *databaseName;
/**
 *  数据表结构
 */
@property(nonatomic,strong)PYStructure *structure;

@property(nonatomic,strong)NSArray *indexes;

@property(nonatomic,strong)NSString *prefixUserDefaultKey;

@property(nonatomic,strong)NSString *prefixBeforeKey;

@property(nonatomic,strong)NSString *prefixAfterKey;



/**
 *  清空数据表
 */
-(void)truncate;

/**
 *  总数据量
 *
 */
-(NSUInteger)count;

/**
 *  数据表是否为空
 *
 *  @return true= 为空 false = 不为空
 */
-(BOOL)isEmpty;

-(NSString *)lastSql;

-(NSString *)databasePath;

#pragma mark - 新增数据

-(void)addFields:(NSDictionary *)fields;

-(void)addFieldsIfNotExist:(NSDictionary *)fields;

-(void)addOrUpdateFields:(NSDictionary *)fields andWhere:(NSString *)where;

#pragma mark - 更新数据
-(void)updateFields:(NSDictionary *)fields andWhere:(NSString *)where;

-(void)setField:(NSString *)field andValue:(id)value andWhere:(NSString *)where;


#pragma mark - 删除数据

-(void)deleteWithWhere:(NSString *)where;

#pragma mark - 查询数据

-(id)getField:(NSString *)field andWhere:(NSString *)where;

-(NSDictionary *)findWithWhere:(NSString *)where;

-(NSArray *)selectAll;

-(NSArray *)selectWithWhere:(NSString *)where;

-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields;

-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields andPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize;

-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields andPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize andOrder:(NSString *)order;


-(BOOL)hasWhere:(NSString *)where;

-(BOOL)hasFields:(NSDictionary *)fields;

@end
