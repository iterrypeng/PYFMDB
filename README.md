PYFMDB
==========

![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
![Pod version](http://img.shields.io/cocoapods/v/PYFMDB.svg?style=flat)
![Platform info](http://img.shields.io/cocoapods/p/PYFMDB.svg?style=flat)
## 前言
之前是一直做web开发，对于做web开发的人而言一定熟悉各种ORM,各种语言针对mysql的ORM有很多，比如PHP的各类框架yii，thinkphp，laravel，ruby语言的rails, GO语言的beego等，IOS开发则面对的数据库是sqlite。FMDB 是基于sqlite的数据库操作类,稳定，但用起来还是不够简洁，PYFMDB是基于FMDB的更高层次的数据库操作类。
## 使用说明
所有的接口都封装在`PYFMDB`类中。以下是一些常用方法说明。
###打开（或创建）数据库
通过`initDbWithName`方法，即可在程序的`Document`目录打开指定的数据库文件。如果该文件不存在，则会创建一个新的数据库。

```
// 打开名为test.sqlite的数据库，如果该文件不存在，则创新一个新的。
PYFMDB *db = [[PYFMDB alloc] initWithDbName:@"test.sqlite"];
```
### 创建数据库表
创建数据库表前可以用set方法设置数据库表前缀
```
db.prefix = @"t_";
```
创建数据库表是通过`createTableWithDict`方法 将数据库表结构以字典形式导入
例如创建一个表名为car，表中有 id，name，wheels 三个子段， id 为自曾字段
```
 NSDictionary *data = @{
                           @"id":@"integer primary key autoincrement",
                           @"name":@"text not null",
                           @"wheels":@"integer",
                           };
[db createTableWithDict:data :@"car"];
```




 
