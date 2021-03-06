PYFMDB
==========

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)]()
![Pod version](http://img.shields.io/cocoapods/v/PYFMDB.svg?style=flat)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/PYFMDB.svg)]()
![Platform info](http://img.shields.io/cocoapods/p/PYFMDB.svg?style=flat)
[![Language](http://img.shields.io/badge/language-OC-brightgreen.svg?style=flat
)](https://en.wikipedia.org/wiki/Objective-C)
[![Build Status](https://api.travis-ci.org/iterrypeng/PYFMDB.svg?branch=master)](https://travis-ci.org/iterrypeng/PYFMDB)
##More Versions
* [简体中文](README_ZH.md) 
* [繁体中文](README_TW.md)

## Intro
PYFMDB base on FMDB, it is a simple ORM!

The package has three parts
* `PYFMDB`  ORM base on FMDB
* `PYTable` Init database,Create table，simple CURD methods 
* `PYStructure` Define the table's structure

##Getting Started
###Import PYFMDB
#### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.
To integrate PYFMDB into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby
pod 'PYFMDB'
```
#### By Hand
Copy the dirs `PYFMDB`,`FMDB` into your project

Search the build-setting  option  `Link Binary With Libraries` and add `libsqlite3.dylib` into it like this
![](http://blog.devtang.com/images/key-value-store-setup.jpg)

###Create Table
Create Table extends `PYTable`，In the demo project, I have named it "CarTable"
#### Set TableName
The codes from CarTable.m  below
```
-(NSString *)tableName{
    return @"car";
}
```
#### Set Table structure
The codes from CarTable.m  below
```
-(PYStructure *)structure{
    PYStructure * st = [[PYStructure alloc] init];
    [st addWithField:@"id" andType:PYStructureTypeAutoInc];
    [st addWithField:@"name" andType:PYStructureTypeNormalText];
    [st addWithField:@"wheels" andType:PYStructureTypeNormalInt];
    return st;
}
```
#####`PYStructureType`
* PYStructureTypeAutoInc = 0,//Auto Increamnt, Primary Key, Int,Not Null
* PYStructureTypePrimaryInt = 1,//Primary Key, Int,Not Null
* PYStructureTypePrimaryText = 2,//Primary Key, Text,Not Null
* PYStructureTypeNormalInt = 3,//Int,Not Null
* PYStructureTypeNormalText = 4,//Text,Not Null

###Table methods
Init Table
```
CarTable *table = [[CarTable alloc] init];
```
####Create 
Insert fields into the Table
```
NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1}; 
[table addFields:fields];
```
If the table has the fields，then  Do Update; otherwise, Do Create;
```
NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1};
[table addOrUpdateFields:fields andWhere:@"name='BMW'"];
```
If the table has the fields, then Do Ignore; otherwise, Do Create;
```
NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1};
[table addFieldsIfNotExist:fields];
```
####Delete
Set where with one condition for delete
```
NSString *where = @"name='BMW'";
[table deleteWithWhere:where];
```
Set where with conditions for delete
```
NSString *where = @"name='BMW' and id >=5";
[table deleteWithWhere:where];
```
Truncate the Table
```
[table truncate];
```
####Update
Update fields
```
NSString *where = @"name='BMW'";
NSDictionary *fields = @{@"name":@"MINI",@"wheels":@2};
[table updateFields:fields andWhere:where];
```
Update one field
```
[table setField:@"name" andValue:@"BMW" andWhere:@"name='MINI'"];
```
####Read
All lines，all fields 
```
NSArray *results = [table selectAll];
```
Where conditions，all fields
```
 NSString *where = @"name='BMW'";
 NSArray *results = [table selectWithWhere:where];
```
Where conditions，some of the fields
```
 NSString *where = @"name='BMW'";
 NSString *fields = @"id,wheels";
 NSArray *results = [table selectWithWhere:where andFields:fields];
```
Where conditions，some of the fields，paging
```
 NSString *where = @"name='BMW'";
 NSString *fields = @"id,wheels";
 //NSString *fields = @"*";//all fields 
NSArray *results = [table selectWithWhere:where andFields:fields andPage:1 andPageSize:10];//first page，pagesize=10
```
Where conditions，some of the fields，paging，ordering
```
 NSString *where = @"name='BMW'";
 NSString *fields = @"id,wheels";
 //ordering has "asc","desc";one field order: id desc;some fields order: id,wheel asc
NSArray *results = [table selectWithWhere:where andFields:fields andPage:1 andPageSize:10 andOrder:@"id desc"];
```
Find one line fields
```
 NSString *where = @"name='BMW'";
 NSDictionary *result = [table findWithWhere:where];
```
Find one field
```
id result = [table getField:@"name" andWhere:@"id=1"];
```
####Table Count
```
NSUInteger tableCount = [table count];
```
####IsEmpty?
```
if([table isEmpty]){
        //table is empty
 }
```
####Has fields?
```
 NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1};
    if([table hasFields:fields]){
        //Yes
    }
```
####Has where?
```
 if([table hasWhere:@"name='BMW'"]){
        //Yes
    }
```

####Origin Sql Support
Execute query sql
```
 NSString *sql = @"select * from car";
 NSArray *results = [table executeQueryWithSql:sql]; 
```
Execute update sql
```
 NSString *sql = @"delete from car where name='BMW'";
 BOOL result = [table executeUpdateWithSql:sql];
```

####Debug
```
NSLog(@"dbpath:%@",table.databasePath);
NSLog(@"lastSql:%@",table.lastSql);
NSLog(@"dbname:%@",table.databaseName);
NSLog(@"tablename:%@",table.tableName);
NSLog(@"table structure:%@",table.structure.structureDictory);
NSLog(@"table fields:%@",table.structure.fieldsString);
```

## Contact

If you find an issue, just [open a ticket](https://github.com/iterrypeng/PYFMDB/issues/new) on it. Pull requests are warmly welcome as well.

## License

PYFMDB is released under the MIT license. See LICENSE for details.
 
