PYFMDB
==========

![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
![Pod version](http://img.shields.io/cocoapods/v/PYFMDB.svg?style=flat)
![Platform info](http://img.shields.io/cocoapods/p/PYFMDB.svg?style=flat)
[![Language](http://img.shields.io/badge/language-OC-brightgreen.svg?style=flat
)](https://en.wikipedia.org/wiki/Objective-C)
[![Build Status](https://api.travis-ci.org/iterrypeng/PYFMDB.svg?branch=master)](https://travis-ci.org/iterrypeng/PYFMDB)
## 前言
之前是壹直做web開發，對於做web開發的人而言壹定熟悉各種ORM,各種語言針對mysql的ORM有很多，比如PHP的各類框架yii，thinkphp，laravel，ruby語言的rails, GO語言的beego等，IOS開發則面對的數據庫是sqlite。FMDB 是基於sqlite的數據庫操作類,穩定，但用起來還是不夠簡潔，PYFMDB是基於FMDB的更高層次的數據庫操作類。
## 程序介紹
`PYFMDB`分為三部分，`PYFMDB` 基於FMDB負責數據庫底層操作處理，`PYTable`是自定義Table的基類，提供基於具體數據庫表的操作，是更高層次的封裝PYFMDB,`PYStructure`是定義數據庫表結構處理類。
##快速入門
###1.導入PYFMDB
妳可以在 Podfile 中加入下面壹行代碼來使用PYFMDB

    pod 'PYFMDB'

妳也可以手動添加源碼使用本項目，將開源代碼中的`PYFMDB`和`FMDB` 目錄添加到妳的工程中，並且在工程設置的`Link Binary With Libraries`中，增加`libsqlite3.dylib`，如下圖所示：

![](http://blog.devtang.com/images/key-value-store-setup.jpg)

###2.創建自定義Table類
創建壹個Table類繼承`PYTable`，例如演示代碼中創建了`CarTable`類。
#### 設置數據庫表名
在CarTable.m 中 重寫如下方法:
```
-(NSString *)tableName{
    return @"car";
}
```
#### 設置數據庫表結構
在CarTable.m 中 重寫如下方法:
```
-(PYStructure *)structure{
    PYStructure * st = [[PYStructure alloc] init];
    [st addWithField:@"id" andType:PYStructureTypeAutoInc];
    [st addWithField:@"name" andType:PYStructureTypeNormalText];
    [st addWithField:@"wheels" andType:PYStructureTypeNormalInt];
    return st;
}
```
`PYStructureType`是定義的結構體，PYStructureTypeAutoInc 代表自增類型字段，PYStructureTypeNormalText 代表普通文本字段，PYStructureTypeNormalInt 代表普通int類型字段
###3.自定義Table類的使用
table類可以實現針對當前table的增刪改查數據庫操作。
```
CarTable *table = [[CarTable alloc] init];
```
####新增數據
普通新增數據
```
NSDictionary *fields = @{@"name":@"寶馬",@"wheels":@1}; 
[table addFields:fields];
```
新增或者更新數據【判斷數據是否已存在，存在則更新數據，不存在則新增數據】
```
NSDictionary *fields = @{@"name":@"寶馬",@"wheels":@1};
[table addOrUpdateFields:fields andWhere:@"name='寶馬'"];
```
判斷是否已經存在數據，僅不存在數據時更新數據
```
NSDictionary *fields = @{@"name":@"寶馬",@"wheels":@1};
[table addFieldsIfNotExist:fields];
```
####刪除數據
指定字段刪除
```
NSString *where = @"name='寶馬'";
[table deleteWithWhere:where];
```
多種條件刪除
```
NSString *where = @"name='寶馬' and id >=5";
[table deleteWithWhere:where];
```
清空數據表
```
[table truncate];
```
####更新數據
更新多個字段
```
NSString *where = @"name='寶馬'";
NSDictionary *fields = @{@"name":@"奔馳",@"wheels":@2};
[table updateFields:fields andWhere:where];
```
更新1個字段
```
[table setField:@"name" andValue:@"奔馳" andWhere:@"name='寶馬'"];
```
####查詢數據
查詢表全部數據，全部字段，返回的結果為NSArray
```
NSArray *results = [table selectAll];
```
按條件查詢數據，全部字段，返回的結果為NSArray
```
 NSString *where = @"name='寶馬'";
 NSArray *results = [table selectWithWhere:where];
```
按條件查詢數據，指定字段，返回結果為NSArray
多個字段用半角逗號隔開
```
 NSString *where = @"name='寶馬'";
 NSString *fields = @"id,wheels";
 NSArray *results = [table selectWithWhere:where andFields:fields];
```
按條件查詢數據，指定字段，設置分頁，返回結果為NSArray
要查詢全部字段時 用 * 代表查詢全部字段
```
 NSString *where = @"name='寶馬'";
 NSString *fields = @"id,wheels";
 //NSString *fields = @"*";
NSArray *results = [table selectWithWhere:where andFields:fields andPage:1 andPageSize:10];//取第壹頁，每頁10條
```
按條件查詢數據，指定字段，設置分頁，設置排序，返回結果為NSArray
排序中 desc 代表 降序，asc代表升序
單個字段排序 如 id desc
多個字段排序 如 id,wheel asc
```
 NSString *where = @"name='寶馬'";
 NSString *fields = @"id,wheels";
 //NSString *fields = @"*";
NSArray *results = [table selectWithWhere:where andFields:fields andPage:1 andPageSize:10 andOrder:@"id desc"];
```
按條件查詢單行數據,返回結果為NSDictionary
```
 NSString *where = @"name='寶馬'";
 NSDictionary *result = [table findWithWhere:where];
```
按條件查詢單行單個字段數據，返回結果為id類型
```
id result = [table getField:@"name" andWhere:@"id=1"];
```
####統計表總行數
```
NSUInteger tableCount = [table count];
```
####判斷表是否為空
```
if([table isEmpty]){
        //table is empty
 }
```
####判斷數據是否存在
```
 NSDictionary *fields = @{@"name":@"寶馬",@"wheels":@1};
    if([table hasFields:fields]){
        //數據已存在
    }
```
####判斷where查詢是否有數據
```
 if([table hasWhere:@"name='寶馬'"]){
        //有查詢結果
    }
```

####調試信息
```
NSLog(@"dbpath:%@",table.databasePath);//數據庫位置
NSLog(@"lastSql:%@",table.lastSql);//最後執行的sql
NSLog(@"dbname:%@",table.databaseName);//數據庫名
NSLog(@"tablename:%@",table.tableName);//數據表名
NSLog(@"table structure:%@",table.structure.structureDictory);//數據表結構
NSLog(@"table fields:%@",table.structure.fieldsString);//數據表字段
```


 
