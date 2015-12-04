//
//  PYTable.m
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "PYTable.h"
#define PYTablePrefixUserDefaultKey @"PYFMDBKEY"
#define PYTablePrefixBeforeKey @""
#define PYTablePrefixAfterKey @""
#define PYDataBaseName @"pyfmdb.sqlite"
@class PYFMDB;
@implementation PYTable
-(instancetype)init{
    if (self = [super init]) {
        //create the table
        if (![self.structure.structureDictory isEqual:nil]) {
            [self.db createTableWithDict:self.structure.structureDictory :self.tableName];
        }
        //create indexes
        if (self.indexes.count >0) {
            for (NSString *index in self.indexes) {
                [self.db createIndexWithField:index andTableName:self.tableName];
            }
        }
    }
    return self;
}


-(PYFMDB *)db{
    if (_db) {
        return _db;
    }
    _db = [PYFMDB dbWithDbName:self.databaseName];
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

-(void)truncate{
    [self.db truncateTableWithTableName:self.tableName];
}

-(NSUInteger)count{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    return [[self.db select] count];
}

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

#pragma mark - create

-(void)addFields:(NSDictionary *)fields{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db add:fields];
}

-(void)addFieldsIfNotExist:(NSDictionary *)fields{
    if (![self hasFields:fields]) {
        [self addFields:fields];
    }
}

-(void)addOrUpdateFields:(NSDictionary *)fields andWhere:(NSString *)where{
    [self hasWhere:where] ? [self updateFields:fields andWhere:where]: [self addFields:fields];
}

#pragma mark - update
-(void)updateFields:(NSDictionary *)fields andWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithString:where];
    [self.db save:fields];
}
-(void)setField:(NSString *)field andValue:(id)value andWhere:(NSString *)where{
    [self updateFields:@{field:value} andWhere:where];
}

#pragma mark - delete
-(void)deleteWithWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    if (![where isEqual:nil]) {
         [self.db whereWithString:where];
    }
    [self.db delete];
}
#pragma mark - read
-(id)getField:(NSString *)field andWhere:(NSString *)where{
    NSDictionary *find = [self findWithWhere:where];
    return [find objectForKey:field];
}
-(NSDictionary *)findWithWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    if (![where isEqual:nil]) {
         [self.db whereWithString:where];
    }
    [self.db fieldsWithString:self.structure.fieldsString];
    return [self.db find];
}

-(NSArray *)selectWithWhere:(NSString *)where{
    return [self selectWithWhere:where andFields:self.structure.fieldsString andPage:0 andPageSize:0 andOrder:nil];
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
    //clean state
    [self.db clean];
    //tablename
    [self.db setCurrentTableName:self.tableName];
    if (pagesize >0) {
        int startNum = page<=0 ? 0:(int)((page -1)*pagesize);
        int endNum = (int)(page*pagesize);
        //limit
        [self.db limitWithStart:startNum End:endNum];
    }
    //where
    if (![where isEqual:nil]) {
       [self.db whereWithString:where];
    }
    //field
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
    //order
    if (![order isEqual:nil]) {
        [self.db setOrder:order];
    }
    return  [self.db select];
}

#pragma mark - has

-(BOOL)hasWhere:(NSString *)where{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithString:where];
    return [[self.db queryCount] intValue] >0;
}

-(BOOL)hasFields:(NSDictionary *)fields{
    [self.db clean];
    [self.db setCurrentTableName:self.tableName];
    [self.db whereWithDict:fields];
    return [[self.db queryCount] intValue] >0;
}


#pragma mark - origin sql
-(NSArray *)executeQueryWithSql:(NSString *)sql{
    return [self.db excuteQueryWithSql:sql];
}

-(BOOL)executeUpdateWithSql:(NSString *)sql{
    return [self.db excuteUpdateWithSql:sql];
}


@end

