//
//  PYFMDB.h
//  Operations library of sqlite base on FMDB
//
//  Created by terry on 15/3/28.
//  Copyright (c) 2015年 Velda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;
@interface PYFMDB : NSObject{
    //以下是因为同时重写了get和set方法,故将变量写在这里
    /**
     *  查询条件
     */
    NSString *_limit;
    NSString *_where;
    NSString *_order;
    NSString *_group;
    /**
     *  缓存ID
     */
    NSString *_cacheID;
}

/**
 *  数据库队列
 */
@property (nonatomic,strong) FMDatabaseQueue * queue;
/**
 *  数据库文件名
 */
@property (nonatomic,copy) NSString * dbName;
/**
 *  数据库文件名(锁定)
 */
@property (nonatomic,copy) NSString * dbName_lock;
/**
 *  数据库位置
 */
@property (nonatomic,copy) NSString * dbPath;
/**
 *  数据库位置(锁定)
 */
@property (nonatomic,copy) NSString * dbPath_lock;
/**
 *  最后执行的sql语句
 */
@property (nonatomic,copy) NSString * lastSql;
/**
 *  最后执行的sql语句(锁定)
 */
@property (nonatomic,copy) NSString * lastSql_lock;
/**
 *  数据库表前缀
 */
@property (nonatomic,copy) NSString * prefix;
/**
 *  数据库表前缀(锁定)
 */
@property (nonatomic,copy) NSString * prefix_lock;
/**
 *  要查询出的字段(默认)
 */
@property (nonatomic,strong)  NSArray * fields;
/**
 *  要查询出的字段(锁定)
 */
@property (nonatomic,strong)  NSArray * fields_lock;

/**
 *  要查询出的字段(字符串)
 */
@property (nonatomic,copy)  NSString * fieldsString;

/**
 *  要查询出的字段(数组)
 */
@property (nonatomic,strong)  NSArray * fieldsArray;
/**
 *  当前操作的表名
 */
@property (nonatomic,copy) NSString * currentTableName;
/**
 *  当前操作的表名(锁定)
 */
@property (nonatomic,copy) NSString * currentTableName_lock;
/**
 *  表里的所有字段
 */
@property (nonatomic,strong)  NSDictionary * currentTableFields;
/**
 *  表里的所有字段(锁定)
 */
@property (nonatomic,strong)  NSDictionary * currentTableFields_lock;
/**
 *  要执行的查询条件(锁定)
 */
@property (nonatomic,copy) NSString * where_lock;

/**
 *  待更新的数据源
 */
@property (nonatomic,strong) id data;
/**
 *  待更新的数据源(锁定)
 */
@property (nonatomic,strong) id data_lock;
/**
 *  Order条件(锁定)
 */
@property (nonatomic,copy) NSString * order_lock;

/**
 *  group条件(锁定)
 */
@property (nonatomic,copy) NSString * group_lock;
/**
 *  缓存标识(锁定)
 */
@property (nonatomic,copy) NSString * cacheID_lock;
/**
 *  查询限制条数(锁定)
 */
@property (nonatomic,copy) NSString * limit_lock;

/**
 *  静态方法初始化数据库连接
 *
 *  @param dbName 数据库名
 *
 *  @return PYFMDB对象
 */
+(instancetype)dbWithDbName:(NSString *)dbName;
/**
 *  动态方法初始化数据库连接
 *
 *  @param dbName 数据库名
 *
 *  @return PYFMDB对象
 */
-(instancetype)initWithDbName:(NSString *)dbName;




/**
 *  根据字典创建数据库表
 *
 *  @param dict      字典
 *  @param tablename 表名
 *
 *  @return 执行是否成功
 */
-(bool)createTableWithDict:(NSDictionary *)dict : (NSString *)tableName;
/**
 *  执行sql查询
 *
 *  @param sql sql语句
 *
 *  @return 查询结果集
 */
-(NSArray *)excuteQueryWithSql:(NSString *)sql;
/**
 *  执行sql更新
 *
 *  @param sql sql语句
 *
 *  @return 执行是否成功
 */
-(bool)excuteUpdateWithSql:(NSString *)sql;

/**
 *  从数组中设置查询的字段信息
 *
 *  @param arr 数组
 *
 *  @return fields数组
 */
-(instancetype)fieldsWithArray:(NSArray *)arr;
/**
 *  从字符串中设置查询的字段信息
 *
 *  @param str 字符串
 *
 *  @return fields数组
 */
-(instancetype)fieldsWithString:(NSString *)str;
/**
 *  从字符串中设置查询的where条件
 *
 *  @param str 字符串
 *
 *  @return where条件
 */
-(instancetype)whereWithString:(NSString *)str;
/**
 *  从字典中设置查询的where条件
 *
 *  @param dict 字典
 *
 *  @return PYFMDB对象
 */
-(instancetype)whereWithDict:(NSDictionary *)dict;
/**
 *  从字符串中设置limit条件
 *
 *  @param str 字符串
 *
 *  @return PYFMDB 对象
 */
-(instancetype)limitWithString:(NSString *)str;
/**
 *  从数组中设置limit条件
 *
 *  @param arr 数组
 *
 *  @return PYFMDB对象
 */
-(instancetype)limitWithArray:(NSArray *)arr;
/**
 *  从start 到 end limit限制
 *
 *  @param start 开始位置
 *  @param End   结束位置
 *
 *  @return PYFMDB对象
 */
-(instancetype)limitWithStart:(int)start End:(int)end;
/**
 *  查询单条记录
 *
 *  @return 字典数据
 */
-(NSDictionary *)find;
/**
 *  从字典添加更新数据源
 *
 *  @param PYFMDB对象
 */
-(instancetype)dataWithDict:(NSDictionary *)dict;
/**
 *  从数组添加更新数据源
 *
 *  @param arr 数组
 *
 *  @return PYFMDB对象
 */
-(instancetype)dataWithArray:(NSArray *)arr;
/**
 *  从JSON中添加更新数据源
 *
 *  @param json json数据
 *
 *  @return PYFMDB对象
 */
-(instancetype)datawithJson:(NSData *)json;
/**
 *  新增记录到数据库
 *
 *  @return 是否执行sql成功
 */
-(bool)add;
/**
 *  按数据源新增记录到数据库
 *
 *  @param data 数据源
 *
 *  @return 是否执行sql成功
 */
-(bool)add:(id)data;
/**
 *  保存记录到数据库
 *
 *  @return 是否执行sql成功
 */
-(bool)save;
/**
 *  从数据源保存记录到数据库
 *
 *  @param data 数据源
 *
 *  @return 是否执行sql成功
 */
-(bool)save:(id)data;
/**
 *  获取指定字段的数据值
 *
 *  @param field 字段名
 *
 *  @return 数据源
 */
-(id)getField:(NSString *)field;
/**
 *  设置指定字段名的值
 *
 *  @param value 字段值
 *  @param field 字段名
 *
 *  @return 是否成功执行sql
 */
-(bool)setValue: (id)value forField:(NSString *)field;
/**
 *  查询到的数据库结果
 *
 *  @return 数组
 */
-(NSArray *)select;
/**
 *  过滤掉非数据库表字段
 *
 *  @param dict 字典数据
 *
 *  @return 过滤后字典数据
 */
-(NSDictionary *)filterWithDict:(NSDictionary *)dict;
/**
 *  执行删除
 *
 *  @return 是否成功执行sql
 */
-(BOOL)delete;
/**
 *  根据where条件删除操作
 *
 *  @param where where条件
 *
 *  @return 是否成功执行sql
 */
-(BOOL)delete:(id)where;
/**
 *  count统计操作
 *
 *  @return 查询结果集数目
 */
-(NSNumber *)queryCount;

/**
 *  清除设置条件
 *
 *  @return PYFMDB对象
 */
-(instancetype)clean;
/**
 *  锁定上次设置条件
 *
 *  @return PYFMDB对象
 */
-(instancetype)lock;
/**
 *  重置到上次设置的条件
 *
 *  @return PYFMDB对象
 */
-(instancetype)reset;
/**
 *  重写order get方法
 *
 *  @return 要排序的条件
 */
- (NSString *)order;
/**
 *  设置order条件
 *
 *  @param order order条件
 */
-(void)setOrder:(NSString *)order;
/**
 *  数据表是否为空
 *
 *  @param tableName 数据库表名
 *
 *  @return bool类型值 YES =为空， NO = 不为空
 */
-(BOOL)isEmptyWithTableName:(NSString *)tableName;
/**
 *  清空数据表
 *
 *  @param tableName 表名
 */
-(void)truncateTableWithTableName:(NSString *)tableName;
/**
 *  公共删除方法
 *
 *  @param dict 字典
 */
-(void)deleteTableWithDict:(NSDictionary *)dict : (NSString *)tableName;
/**
 *  展示Table数据
 *
 *  @param page     当前页
 *  @param pagesize 分页大小
 *  @param tableName 表名
 *
 *  @return 数组
 */
-(NSArray *)showTableWithPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize andTableName:(NSString *)tableName;
/**
 *  展示Table数据
 *
 *  @param page      当前页
 *  @param pagesize  分页大小
 *  @param order     排序
 *  @param tableName 表名
 *
 *  @return 数组
 */
-(NSArray *)showTableWithPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize andOrder:(NSString *)order andTableName:(NSString *)tableName;

/**
 *  展示Table数据
 *
 *  @param fields    字段，（多个字段半角逗号隔开）
 *  @param page      当前页
 *  @param pagesize  分页大小
 *  @param tableName 表名
 *
 *  @return 数组
 */
-(NSArray *)showTableWithFields:(NSString *)fields andPage:(NSUInteger)page andPageSize:(NSUInteger)pagesize andTableName:(NSString *)tableName;


/**
 *  展示Table数据
 *
 *  @param fields    字段，（多个字段半角逗号隔开）
 *  @param page      当前页
 *  @param pagesize  分页大小
 *  @param order     排序
 *  @param tableName 表名
 *
 *  @return 数组
 */
-(NSArray *)showTableWithFields:(NSString *)fields andPages:(NSUInteger)page andPageSize:(NSUInteger)pagesize andOrder:(NSString *)order andTableName:(NSString *)tableName;
#pragma mark - cache 缓存处理方法
/**
 *  将数据缓存入文件
 *
 *  @param data     数据源
 *  @param cacheKey 缓存键名
 *
 *  @return 是否成功缓存
 */
-(BOOL)setObject:(id)data ForCacheKey:(NSString *)cacheKey;
/**
 *  根据缓存键名读取缓存内容
 *
 *  @param cacheKey 缓存键名
 *
 *  @return 缓存键值
 */
- (id )objectForCacheKey:(NSString *)cacheKey;
#pragma mark - 索引操作
/**
 *  为字段创建普通索引
 *
 *  @param field     字段名称
 *  @param tableName 表名
 *
 *  @return 执行是否成功
 */
-(bool)createIndexWithField:(NSString *)field andTableName: (NSString *)tableName;
@end
