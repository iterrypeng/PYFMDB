//
//  PYTable.m
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "PYTable.h"
#define PYTablePrefixUserDefaultKey @"uid"
#define PYTablePrefixBeforeKey @"u"
#define PYTablePrefixAfterKey @"_"
#define PYDataBaseName @"pyfmdb.sqlite"
@class PYFMDB;
@implementation PYTable
-(instancetype)init{
    if (self = [super init]) {
        //创建表
        if (![self.structure.structureDictory isEqual:nil]) {
            [self.db createTableWithDict:self.structure.structureDictory :self.tableName];
        }
        //创建索引
        [self.indexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.db createIndexWithField:obj andTableName:self.tableName];
        }];
    }
    return self;
}

/**
 *  db初始化
 *
 *  @return PYFMDB数据库对象
 */
-(PYFMDB *)db{
    if (_db) {
        return _db;
    }
    //初始化数据库表
    _db = [PYFMDB dbWithDbName:self.databaseName];
    //设置数据库表前缀为用户id
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:self.prefixUserDefaultKey];
    _db.prefix = userID==nil ? [NSString stringWithFormat:@"%@%@",self.prefixBeforeKey,self.prefixAfterKey]:[NSString stringWithFormat:@"%@%@%@",self.prefixBeforeKey,userID,self.prefixAfterKey];
    return _db;
}

-(NSString *)databaseName{
    if (_databaseName) {
        return _databaseName;
    }
    _databaseName = PYDataBaseName;
    return _databaseName;
}

-(NSString *)prefixAfterKey{
    if (_prefixAfterKey) {
        return  _prefixAfterKey;
    }
    _prefixAfterKey = PYTablePrefixAfterKey;
    return _prefixAfterKey;
}

-(NSString *)prefixBeforeKey{
    if (_prefixBeforeKey) {
        return _prefixBeforeKey;
    }
    _prefixBeforeKey = PYTablePrefixBeforeKey;
    return _prefixBeforeKey;
}

-(NSString *)prefixUserDefaultKey{
    if (_prefixUserDefaultKey) {
        return _prefixUserDefaultKey;
    }
    _prefixUserDefaultKey = PYTablePrefixUserDefaultKey;
    return _prefixUserDefaultKey;
}

-(PYStructure *)structure{
    if (_structure) {
        return _structure;
    }
    _structure = [[PYStructure alloc] init];
    return _structure;
}
/**
 *  清空数据表
 */
-(void)truncate{
    [self.db truncateTableWithTableName:self.tableName];
}
/**
 *  总数据量
 *
 */
-(NSUInteger)count{
    //重置查询条件
    [self.db clean];
    //选择要操作的表名
    [self.db setCurrentTableName:self.tableName];
    return [[self.db select] count];
}

/**
 *  数据表是否为空
 *
 *  @return true= 为空 false = 不为空
 */
-(BOOL)isEmpty{
    if ([self count] >0) {
        return false;
    }
    return true;
}

-(NSString *)lastSql{
    return self.db.lastSql;
}

-(NSString *)databasePath{
    return self.db.dbPath;
}

#pragma mark - 新增数据

-(void)addFields:(NSDictionary *)fields{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db add:fields];
}

#pragma mark - 修改数据
-(void)updateFields:(NSDictionary *)fields andWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithString:where];
    [self.db save:fields];
}
-(void)setField:(NSString *)field andValue:(id)value andWhere:(NSString *)where{
    [self updateFields:@{field:value} andWhere:where];
}

#pragma mark - 删除
-(void)deleteWithWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithString:where];
    [self.db delete];
}
#pragma mark - 查询
-(id)getField:(NSString *)field andWhere:(NSString *)where{
    NSDictionary *find = [self findWithWhere:where];
    return [find objectForKey:field];
}
-(NSDictionary *)findWithWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithString:where];
    return [self.db find];
}

-(NSArray *)selectWithWhere:(NSString *)where{
    return [self selectWithWhere:where andFields:nil andPage:0 andPageSize:0 andOrder:nil];
}
-(NSArray *)selectAll{
    return [self selectWithWhere:@"1"];
}

-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields{
    return [self selectWithWhere:where andFields:fields andPage:0 andPageSize:0 andOrder:nil];
}

-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields andPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize{
    return [self selectWithWhere:where andFields:fields andPage:page andPageSize:pagesize andOrder:nil];
}
-(NSArray *)selectWithWhere:(NSString *)where andFields:(NSString *)fields andPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize andOrder:(NSString *)order{
    //重置查询条件
    [self.db clean];
    //选择要操作的表名
    [self.db setCurrentTableName:self.tableName];
    if (pagesize >0) {
        int startNum = page<=0 ? 0:(int)((page -1)*pagesize);
        int endNum = (int)(page*pagesize);
        //limit条件
        [self.db limitWithStart:startNum End:endNum];
    }
    //where条件
    if (![where isEqual:nil]) {
       [self.db whereWithString:where];
    }
    //field条件
    if (![fields isEqual:nil]) {
        if ([fields isEqualToString:@"*"]) {
            [self.db fieldsWithString:self.structure.fieldsString];
        }
        else{
            [self.db fieldsWithString:fields];
        }
    }
    else{
        [self.db fieldsWithString:self.structure.fieldsString];
    }
    //order条件
    if (![order isEqual:nil]) {
        [self.db setOrder:order];
    }
    return  [self.db select];
}
@end

