//
//  ViewController.m
//  pyfmdbdemo
//
//  Created by pengyong on 15/11/3.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "ViewController.h"
#import "PYFMDB.h"
@interface ViewController ()
@property(nonatomic, strong)PYFMDB *db;
- (IBAction)add;
- (IBAction)update;
- (IBAction)delete;
- (IBAction)query;
- (IBAction)truncate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 1 链接数据库
    self.db = [[PYFMDB alloc] initWithDbName:@"car.sqlite"];
    
    // 2 创建表
    // 2.1 设置表的前缀
    self.db.prefix = @"t_";
    
    // 2.2 设置表的字段
    NSDictionary *data = @{
                           @"id":@"integer primary key autoincrement",
                           @"name":@"text not null",
                           @"wheels":@"integer",
                           };
    
    [self.db createTableWithDict:data :@"car"];
    
    NSLog(@"sql:%@",self.db.dbPath);
}



- (IBAction)add {
    // 1 重置查询条件
    [self.db clean];
    // 2 选择要操作的表
    [self.db setCurrentTableName:@"car"];
    // 3 添加数据
    for (int i=0; i<10; i++) {
        NSDictionary *data = @{
                               @"name":@"奥迪",
                               @"wheels":@4 ,
                               };
        [self.db add:data];
    }
    NSLog(@"sql:%@",self.db.lastSql);
    
}

- (IBAction)update {
    // 1 重置查询条件
    [self.db clean];
    
    // 2 选择要操作的表
    [self.db setCurrentTableName:@"car"];
    
    // 3 设置更新条件
    [self.db whereWithString:@"id > 2"];
    // 4 保存更新条件
    [self.db save:@{@"name":@"奔驰"}];
    
    NSLog(@"currentsql:%@",self.db.lastSql);
}

- (IBAction)delete {
    // 1 重置查询条件
    [self.db clean];
    
    // 2 选择要操作的表
    [self.db setCurrentTableName:@"car"];
    
    // 3 设置删除条件
    NSDictionary *data = @{
                           @"id":@1,
                           };
    
    // 4 删除
    [self.db delete:data];
    NSLog(@"currentsql:%@",self.db.lastSql);
    
}

- (IBAction)query {
    // 1 重置查询条件
    [self.db clean];
    
    // 2 选择要操作的表
    [self.db setCurrentTableName:@"car"];
    // 3 设置查询字段
    self.db.fields = @[@"id",@"name"];
    // 4 设置限制
    [self.db setLimit:@"1,10"];
    // 5 设置查询条件
    [self.db whereWithString:@"id >1"];
    // 6 设置顺序
    self.db.order = @"id desc";
    // 7 查询结果
    NSArray *results = [self.db select];
    NSLog(@"currentsql:%@",self.db.lastSql);
    NSLog(@"%@",results);
    
}

- (IBAction)truncate {
    // 1 重置查询条件
    [self.db clean];
    // 2 选择要操作的表
    [self.db setCurrentTableName:@"car"];
    // 3 设置查询条件
    [self.db whereWithString:@"1"];
    // 4 删除
    [self.db delete];
     NSLog(@"currentsql:%@",self.db.lastSql);
}

@end